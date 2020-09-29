use_bpm 100

melody1 = [:b3, :e3, :g3, :e3]
melody2 = [:a3, :e3, :f3, :e3]
n = 6

transpose = knit(0, 5, 12, 1, 7, 2, 5, 1)
live_loop :beat do
  sleep 1
end

speed = (ring 1, 0.5)
live_loop :synth, sync: :beat do
  use_transpose transpose.choose
  play_pattern_timed melody1, speed.choose
  use_transpose transpose.choose
  play_pattern_timed melody2, speed.choose
end

beet_pattern = (ring 1, 0, 0, 0)
live_loop :beet, sync: :beat do
  with_fx :reverb do
    sample :bd_haus, cutoff: 79 if beet_pattern.tick == 1
    sleep 0.5
    sample :bd_haus, cutoff: 79 if beet_pattern.tick == 1 and one_in(4)
    sleep 0.5
  end
end

live_loop :snare, sync: :beat do
  with_fx :reverb do
    sample :bd_fat, cutoff: 130 if beet_pattern.tick == 0
    sleep 0.5
    sample :bd_fat, cutoff: 130 if beet_pattern.tick == 0 and one_in(4)
    sleep 0.25
    sample :bd_fat, cutoff: 130 if beet_pattern.tick == 0 and one_in(4)
    sleep 0.25
  end
end


synth_a = (line 0.3, 1, steps: (n/2)).mirror
synth_pan = (line -1, 1, steps: n)

live_loop :spit, sync: :beat do
  tick
  if (one_in(3))
    sleep n
  else
    c = synth :hollow, note: [:e4, :e5].choose, amp: 0, sustain: 6, amp_slide: 1, cutoff: 70
    n.times do
      control c, amp: synth_a.look, pan: synth_pan.look
      sleep n/n
      tick
    end
  end
end


blank = [:r, :r, :r, :r]
live_loop :dark_m, sync: :beat do
  with_fx :ping_pong do
    with_fx :lpf do
      use_transpose 7+12
      use_synth :dark_ambience
      use_synth_defaults amp: 0.7, attack: 0, release: 0.1, cutoff: 88
      notes = [melody1, melody2, blank, blank].choose
      play_pattern_timed notes.take(3), [1, 0.25, 0.75]
      sleep 1
      x = one_in(2)
      play notes.last() ,sustain: 0.25, release: 1 if x
      sleep 0.75
      play notes.first() ,sustain: 0.25, release: 1 if !x
      sleep 1.5
    end
  end
end

