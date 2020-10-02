use_bpm 60
use_random_seed 42
#only one synth, no samples
use_synth :sine

primary = 60
notes=[primary, primary-3, primary, primary-7, primary]
dur=line(0.5, 2.5, steps: 5)
chord_type = [:minor]


define :sum do |x|
  n = 0.0
  for i in 0..x.size
    n = x[n] + n
  end
  return n
end

total_dur = sum(dur)

live_loop :melody do
  print total_dur
  ns = notes.shuffle
  d = dur.shuffle
  c = play :fs4, sustain: 1, decay: total_dur - 1, slide: rrand(0.2,0.5)
  (dur.size).times do
    control c, note: ns.tick(:n)
    sleep d.tick(:d)
  end
end

live_loop :chord do
  sync :melody
  with_fx :echo, phase: 0.5, decay: notes.size * 2.5 do
    play_pattern_timed chord(notes.choose, chord_type.choose), 0.001
    sleep 0.25
    play notes[0] if !one_in(4)
    sleep 1
  end
end

live_loop :crunch do
  sync :melody
  v = total_dur - rrand(1,4)
  sleep rrand(1,4)
  with_fx :hpf do
    with_fx :bitcrusher, bits: 8 do
      play 60, sustain: 0, attack: 0.5, release: 3, amp: 0.3, pan: -0.7 if !one_in(4)
      sleep rrand(1,4)
    end
  end

end

live_loop :hurlevent do
  sync :melody
  timez = 140
  with_fx :lpf do
    x = play primary - 12 - [0,5,7].choose, attack: 0.5, sustain: total_dur - 1.5, release: 1,
      cutoff: 67
    n = 0
    timez.times do
      n = n+0.05
      control x, amp: [0.99,Math.sin(n).abs+0.2].min
      sleep total_dur / timez
    end
  end
end

define :kick do
  play primary, slide: 0.05, release: 0.1, sustain: 0.5
  control note: :c1
end

live_loop :heartbeat do
  sync :melody
  sleep total_dur - (rrand 1,3)
  with_fx :reverb do
    kick
    sleep 0.5
    kick if !one_in(4)
  end
end