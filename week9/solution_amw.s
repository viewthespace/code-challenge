;; numbers = []
define numbers $00

;; numbers_length = 7
define numbers_length $07

;; init()
;; loop()
;; exit
  JSR init
  JSR loop
  JSR end

;;
;; numbers = [5, 3, 5, 1, 3, 1, 2]
;; i = 0
;; acc = 0
;;
  init:
  LDX #$00

  LDA #$05
  STA numbers, X

  INX
  LDA #$03
  STA numbers,X

  INX
  LDA #$05
  STA numbers,X

  INX
  LDA #$01
  STA numbers,X

  INX
  LDA #$03
  STA numbers,X

  INX
  LDA #$01
  STA numbers,X

  INX
  LDA #$02
  STA numbers,X

  LDX #$00

  LDA #$0
  RTS

;;
;; while(i < numbers_length) do
;;   acc = acc ^ numbers[i]
;;   i += 1
;; end
loop:
  JSR holy_trinity
  CPX #numbers_length
  BNE loop
  RTS

;;
;; acc = acc ^ numbers[i]
;;
holy_trinity:
  EOR numbers,X
  INX
  RTS

end:
  BRK
