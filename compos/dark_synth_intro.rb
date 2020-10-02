use_bpm 120
BAR=6.0
t1 = 1.0
t2 = t1 / 2
t4 = t2/ 2
t8 = t4/ 2

live_loop :background do
  synth :hoover, note: [:e2, :e3], sustain: BAR*10, attack: 0.5, release: 0.5, cutoff: 77, amp: 1
  sleep BAR*10
end

sleep BAR*4

live_loop :gloomy_stabs do
  #parameters
  bar=BAR
  resolution = 8.0

  c=0;d=0;
  with_fx :lpf, mix: 0.6 do
    c = synth :saw, note: 29,
      sustain: 2, attack: 0.1, release: 1.5,
      amp: 1, cutoff: 90,
      note_slide: 0.5
  end
  with_fx :hpf, mix: 0.8 do
    d = synth :dpulse, note: 33,
      sustain: 1.5, attack: 0.1, release: 2,
      amp: 1, cutoff: 90,
      note_slide: 0.1
  end
  resolution.times do
    control c, note: (line 29, 28, step: resolution).tick
    control d, note: (line 29, 28, step: resolution).tick
    sleep bar/resolution
  end
end


p1 = (ring t1, t4, t4, t2)
p2 = (ring t4, t2, t2, t4, t1, t4)
patterns = knit(p1, 3, p2, 1)
pans = (ring -0.5, 0.5)
live_loop :horse_rythm, sync: :gloomy_stabs do
  sync :gloomy_stabs
  pattern = patterns.tick(:patterns)
  tick_reset :p1
  with_fx :reverb do
    s = :bd_tek
    pattern.size.times do
      sample s, pan: pans.tick(:pans)
      sleep pattern.tick(:p1)
    end
  end
end

mystery_melody = [:gs4, :g4, :e4]
conclusion_melody = [:gs4, :g4, :e5]
melodies = knit(mystery_melody, 7, conclusion_melody, 1)
melody_ramp = (line 60, 100, steps: 8)
live_loop :melody, sync: :gloomy_stabs do
  sync :gloomy_stabs
  sleep 3
  melody = melodies.tick(:melodies)
  tick_reset :melody
  use_synth :hoover
  use_synth_defaults  sustain: 2.7, attack: 0.1, release: 0.3,
    cutoff: melody_ramp.tick, amp: 0.8
  s = synth :hoover, note: melody.tick(:melody), attack: 0.5
  sleep 3
  s = synth :hoover, note: melody.tick(:melody)
  sleep 3
  s = synth :hoover, note: melody.tick(:melody), sustain: 2, release: 9
  sleep BAR*2
end