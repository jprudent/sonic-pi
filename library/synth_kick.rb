use_synth :sine

live_loop :kick do
  click = play :c3, release: 0.0125, amp: 5
  pop = play :c2, decay: 0.05, decay_level: 0.5, release: 0.25, amp: 2
  body = play :c2, sustain_level: 0.8, release: 0.8, amp: 2
  sleep 1
end

#### OR

live_loop :kick do
  use_synth :tri
  play :c3, slide: 0.05, release: 0.1
  control note: :c1
  sleep 1
end

### OR

live_loop :kick do
  use_synth :tri
  with_fx :level, amp: 3 do
    #increase cutoff for clearer kick
    # increase res for a more harmonic kick
    with_fx :rlpf, cutoff: 66, res: 0.6 do
      #increase slide for a psytrance kick
      #increase notes for happier kick
      play :c3, slide: 0.05, release: 0.1
      control note: :c1
    end
  end
  sleep 0.250
end