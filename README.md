# Rime Triple Vietnamese

## About
This is a input method for typing vietnamese syllables in three keys.

## Resource
- Luong Hieu Thi
  - [All syllables in Vietnamese language](https://www.hieuthi.com/blog/2017/03/21/all-vietnamese-syllables.html)
  - [common-vietnamese-syllables.txt](https://gist.github.com/hieuthi/1f5d80fca871f3642f61f7e3de883f3a)
- tunc2112
  - [vietnamese-syllable-regex](https://github.com/tunc2112/vietnamese-syllable-regex/)

## Todo
- [ ] Designing a properly layout
  - [ ] Finding data on Vietnamese syllable frequency
- [x] Capitalization
  - inp -> nam
  - Inp -> Nam
  - INP -> NAM
- [ ] Checks
  - [ ] Coverage of syllables
  - [ ] Tone mark placements
- [ ] Supporting old and new tone marking styles
  - A switch for tone mark style
- [x] Output for shorter codes
  - 1: onset
  - 2: final
- [ ] Integrating input methods like Telex or VNI
- [ ] Entering Vietnamese letters in ascii mode
- [x] Have two keys for commit with space and commit without space
  - inp + <space> -> commit "nam "
  - inp + <enter> -> commit "nam"
- [ ] Supporting Chữ Nôm (𡨸喃) and Chữ Hán (𡨸漢)
- [ ] Symbols
  - Other motified Latin letters
  - Korean Hangul
  - Japanese Kana
  - Greek Alphabet
  - Emoji
  - etc.
