°(+1) 5
°⊟ [1 2] # Very common!
°∿ 1     # Arcsine
°□ ⊢{"unbox" "me!"}
⊟₃ 1 2 3
°⊟₃ [1 2 3]
°⊟₃ {1 2_3 "hmmm"}
°△ 5_5
°△ 2_3_4
°⊏ "enumerate"
⌝+ 3 5
⌝ⁿ 4 81           # Nth root
⌝↘ 1_¯2 [1_2 3_4] # Pad
⬚@-⌝⊏ 1_2_5 "abc"
⬚0⌝⊡ [2_2 0_4] 3_5
⍜(⊡2|×10) [1 2 3 4]
⍜⊡× 2 [1 2 3 4] 10
⍜⊡× 2 [1 2 3 4] 10
⍜(⊡2)⋅∞ [1 2 3 4]
⍜⊡◌ 2 [1 2 3 4] ∞
⍜(↙2)/× [3 5 4 2]
⍜(↻3|⊂0) [1 2 3 4 5]
⍜×⁅ 1e3 π
.↯3_4⇡12
⍜♭⇌
≡⍜°□(⊂:@!) {"wow" "cool" "omg"}
Person  ← {⊙⊙∘}
Name    ← °□⊡0
Surname ← °□⊡1
Age     ← °□⊡2

FmtPerson ← $"_ is _ years old" ⊃(Name|Age)
PassYear  ← ⍜Age(+1)

Dan ← Person "Dan" "Danson" 31
FmtPerson Dan
FmtPerson PassYear Dan
⍜⊢(×10) [2 3 4]
°⊸⊢ 0 [2 3 4]
°⊸(⊡2) 5 [1 2 3 4]
Lerp ← +⊃⊢(×/-)
Lerp 10_20 0
Lerp 10_20 0.5
Lerp 10_20 1
Lerp 10_20 1.5
Lerp 10_20 2
Lerp ← ⌅(
  +⊃⊢(×/-) # Normal lerp
| ÷⊃/-(-⊢) # Invert the lerp
)
Lerp ← ⌅(+⊃⊢(×/-)|÷⊃/-(-⊢))
Lerp 10_20 0.5
°(Lerp 10_20) 30
⌝Lerp 10_20 5
⍜Lerp(+5) 10_20 0.5
