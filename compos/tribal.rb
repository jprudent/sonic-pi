# Copyleft - Jérôme Prudent
# https://in-thread.sonic-pi.net/t/sonic-pi-monthly-challenge-1/4442
# Sonic Pi monthly challenge : "Make any piece of sound from a single sample"
# The sample for this piece is downloadable at https://freesound.org/people/Kyster/sounds/140615/

sample_path = "/home/jerome/p/songs/Library/Sound FX & Scratches/bottle-cork-in-and-out-2012-1-4.wav"
sample_d = sample_duration(sample_path)
puts "sample duration #{sample_d}"

define :sample_slicer do |start_end|
  start_end.collect { |x| (sample_d - x) / sample_d }
end

percu = sample_slicer([3.49, 3.23])
puts "percu : #{percu}"

define :play_percu do |rate, pitch = 0|
  if (rate != 0)
    return sample sample_path, amp: 1, start: percu[0], finish: percu[1], rate: rate, pitch: pitch
  end
end




t1 = 1.0
t2 = t1 / 2
t4 = t2/ 2
t8 = t4/ 2

b = bass = 0.5
m = medium = 0.75
h = high = 1
r = repos = 0
rs = [
    #0
    [(ring b, b, m, m,  b, b, h, h, b, b, m, m, b, b, h, h), (ring t8)],
    [(ring b, r, m, m,  r, r, h, r), (ring t8)],
    [(ring b, r, m, m,  r, b, h, r,  b, r, r, m,  b, b, m, r), (ring t8)],
    [(ring b, m, m, r,  b, r, h, h,  b, h, r, h,  b, r, h, h), (ring t8)],
    #4
    [(ring h, r, r, h,  h, r, m, m), (ring t8)],
    [(ring b, r, r, b,  b, r, m, m), (ring t8)],
    [(ring h, r, r, h,  h, r, b, r,  h, r, m, m,  h, r, b, r), (ring t8)],
    [(ring b, b, m, m,  b, b, h, h,  b, b, m, m,  b, b, h, h), (ring t8)],
    #8
    [(ring b, r, m, m,  b, h, h, r,  b, r, m, m,  b, h, h, r), (ring t8)],
    [(ring m, m, r, h,  m, m, h, r,  m, m, h, r,  m, m, h, r), (ring t8)],

]

set :timbre, rs[0][0]
set :rythm, rs[0][1]

live_loop :ticks do |cpt|
  sleep t8+0.001
  x = rand_i(rs.size)
  if (factor?(cpt, 10*8))
    x = rand_i(rs.size)
    puts "Change rythm #{x}"
    set :timbre, rs[x][0]
    set :rythm, rs[x][1]
  end
  cpt += 1
end

#you can change the pattern easily

with_fx :lpf do
  with_fx :distortion do
    live_loop :percu do
      sync :ticks
      timbre = get :timbre
      rythm = get :rythm
      rythm.tick(:rythm)


      if play_percu timbre.tick(:timbre)
        set :current_rythm, rythm.look(:rythm)
      end

      sleep rythm.look(:rythm)
    end
  end
end

live_loop :fast_tictictic do
  sync :ticks
  speed = knit(0, 2, 1, 2, 2, 1).choose
  probability = (knit true, 2, false, 1)
  with_fx :hpf do
    t = (sync :current_rythm) - 0.001
    speed.times do
      play_percu 8 if probability.tick(:proba)
      sleep t / speed
    end
  end
end

with_fx :reverb do
  live_loop :melody do
    t = (sync :current_rythm)
    if (true)
      sleep t
      a, b, c = (chord 0, knit(:m7, 3, :dim7, 2, :dom7, 1).choose)
      n = t4 / [1, 2].choose
      sample sample_path, amp: 1, start: percu[0], finish: percu[1], rate: 2, rpitch: a
      sleep n
      sample sample_path, amp: 1, start: percu[0], finish: percu[1], rate: 2, rpitch: b
      sleep n
      sample sample_path, amp: 1, start: percu[0], finish: percu[1], rate: 2, rpitch: c
    end
  end
end

