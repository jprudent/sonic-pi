t1 = 1.0
t2 = t1 / 2
t4 = t2 / 2
t8 = t4 / 2
t16 = t8 / 2

ts = [t2, t4, t8]
p1s = [:tabla_ghe1, :tabla_ghe2, :tabla_ghe3, :tabla_ghe4, :tabla_ghe7, :tabla_ghe8]
p2s = [:tabla_tas1, :tabla_tas2, :tabla_tas3, :tabla_na, :tabla_na_o, :tabla_na_s]
p3s = [:tabla_tun1, :tabla_tun2, :tabla_tun3]

define :play_percu do |p|
  s = p[0]
  print s
  w = p[1]
  pa = p[2] || 0
  sample s, pan: pa
  sleep w
end

with_random_seed 1 do
  with_fx :reverb, room: 0.2 do
    live_loop :randomeur1 do
      p = -0.8
      if (factor?(tick, 2))
        p = 0.8
      end

      8.times do
        play_percu([p2s.choose, ts.choose, p])
      end
    end

    live_loop :randomeur2 do
      sync :randomeur1
      4.times do
        play_percu([p3s.choose, ts.choose]) if not(one_in(3))
        sleep ts.choose
      end
    end
  end
end
