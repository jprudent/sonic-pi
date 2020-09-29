live_loop :tacotac do
  notes = (scale :e4, :minor_pentatonic).shuffle.take(4)
  c = synth :hoover, note: notes.tick, attack: 0.5, sustain: 8, release: 0.5,
    note_slide: 0.5, cutoff: 100, res: 0.4
  sleep 0.5
  14.times do
    control c, note: notes.choose
    sleep 0.5
  end
  sleep 1
end