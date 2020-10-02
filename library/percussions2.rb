t1 = 1.0
t2 = t1 / 2
t4 = t2/ 2
t8 = t4/ 2
#you can change the pattern easily
times = (ring t4, t2, t2, t4, t1, t4)
pans = (ring -0.5, 0.5)
live_loop :horse do
  with_fx :reverb do
    use_bpm 120
    s = :bd_tek
    sample s, pan: pans.tick(:p)
    sleep times.tick
  end
end