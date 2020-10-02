live_loop :basso do
  use_synth :tb303
  play chord(:C2, :major).choose, release: 0.125, cutoff: rrand(60, 110)
  sleep 0.25
end