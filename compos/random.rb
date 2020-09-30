use_random_seed 12
live_loop :random_riff do
  use_random_seed rand_i(19999)
  use_synth :prophet
  s = [0.125, 0.25, 0.5].choose
  8.times do
    t = [1, 1, 1, 2, 2, 3].choose
    r = [0.125, 0.25, 1, 2].choose
    n = (scale :e3, :minor).shuffle.take(t)
    co = rrand(80,100)
    play n, release: r, cutoff: 100
    sleep s
  end
end

live_loop :drums do
  use_random_seed rand_i(123)
  16.times do
    r = rrand(0.5,10)
    sample :drum_bass_hard, rate: r, amp: rand
    sleep 0.125
  end
end