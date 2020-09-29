live_loop :tacotac do
  use_random_seed 100
  notes = (scale :e3, :minor_pentatonic).shuffle
  8.times do |x|
    a=0.5
    if (x==0 || x==4)
      a = 1
    end
    print a
    c = synth :piano, note: notes.tick, vel: 0.3, hard: rrand(0.4,0.6), stereo_width: 1, amp: a
    sleep 0.250
  end
end

####
# more sofiticated with 2 pianos

intervals = knit(0, 4, 7, 1, 5, 1)
live_loop :tacotac do
  use_random_seed rand_i(500)
  use_bpm 60
  notes = (scale :e1, :minor_pentatonic).shuffle
  interval = intervals.tick
  8.times do |x|
    a=0.5
    if (x==0 || x==4)
      a = 1
    end
    print a
    c = synth :piano, note: notes.tick, vel: 0.4, hard: rrand(0.4,0.6), stereo_width: 1, amp: a
    c = synth :piano, note: notes.tick + 36 + interval, vel: 0.4, hard: rrand(0.4,0.6), stereo_width: 1, amp: 0.6 if not(one_in(5))
    sleep 0.250
  end
end