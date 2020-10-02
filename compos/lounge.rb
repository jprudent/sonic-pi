# Copyleft - Jérôme Prudent

notes = (scale :c, :major)

live_loop :main do
  n = notes.choose
  # changing this will adapt the amen speed
  r = (line 1.5, 2, steps: 20).mirror.tick
  # changing this gives a new feeling, the amen may not be suited for all kind of chords
  c_type = [:minor7, :major7].choose
  set :note, [n,r,0, c_type]
  sleep r
end

live_loop :parrot do
  n,r,transp, chord_type = sync :note
  use_synth :sine
  sleep rrand(0.1, 0.2)
  parrot = chord(n, chord_type, invert: [0,1,2].choose)
  if one_in(2)
    parrot = parrot.reverse
  end
  use_transpose transp
  rythme = [0.5, 0.125, 0.250]

  play parrot[0], amp: 0.7
  sleep rythme.tick
  play parrot[1], amp: 0.5
  sleep rythme.tick
  with_fx :flanger do
    play parrot[2], amp: 0.7
    sleep rythme.tick
  end

end

live_loop :chords do
  use_synth :dpulse
  n,r,transp, chord_type = sync :note
  use_transpose -0
  ch = chord(n, chord_type)
  with_fx :lpf do
    with_fx :reverb do
      play_chord ch, attack: 0.2, sustain: [0.5,(r - 1 - 0.2)].max, release: 1, cutoff: 44, amp: 0.7
    end
  end
  sleep 0.1
end

live_loop :rythme do
  n,r,transp, chord_type = sync :note
  with_fx :ixi_techno, mix: knit(1, 1, 0, 9).choose do
    sample :loop_amen, beat_stretch: r, amp: 0.5
  end
  sleep r-0.1
end