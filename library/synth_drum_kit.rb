#Yeah, filters are great! A quick rundown:
#You have a hpf, lpf, and bpf.
#hpf is a high pass filter, it will remove frequencies below the cutoff while keeping frequencies above.
#lpf is a low pass filter, the knob twiddler’s bread and butter. It will cut frequencies above the cutoff while allowing ones below.
#bpf is a band pass filter. Frequencies above and below the cutoff will be removed and frequencies near the cutoff will be kept.
#All of these filters have an “r” version, for instance :rlpf . The R stands for resonant, meaning that the cutoff will have a steeper slope that can be controlled, emphasizing nearby frequencies. At extreme levels, the filter can itself resonate create a sine wave at the cutoff level. Great for carving a flute sound out of noise.
#Finally, all of these have an “n” variation, which stands for Normalized. I haven’t actually thought to use these, but should. These add a normalizer to the effect so that cutting frequencies doesn’t make the sound too quiet to hear.

live_loop :kick do
  use_synth :tri
  play :c3, slide: 0.05, release: 0.1
  control note: :c1
  sleep 1
end

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

# make snares louder by decreasing cutoff
live_loop :snare do
  sleep 0.5
  with_fx :rlpf, cutoff: 95, res: 0.55 do
    synth :beep, note: :f3, release: 0.07, slide: 0.07
    control note: :ds3
    synth :noise, release: 0.05, amp: 0.6
  end
  sleep 0.5
end

# make hats louder by decreasing cutoff
live_loop :hats do
  use_synth :noise
  nlen = [0.0625, 0.125, 0.25].choose
  with_fx :hpf, cutoff: 105 do
    4.times do
      play 64, release: rrand(0.03, 0.04)
      sleep nlen
    end
  end
end