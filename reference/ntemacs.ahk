;;; -*- coding: utf-8-with-signature-dos -*-

;;;
;;; Windows の操作を Emacs のキーバインドで行うための設定（AutoHotKey版）
;;;

;; このスクリプトは、次のページを参考として作成したものです。
;;   http://usi3.com/emacs-like-keybindings-on-windows.html
;; このページの作者に感謝します。

;; このスクリプトは、AutoHotkey_L (Unicode版）で動作確認しています。
;;   http://ahkwiki.net/Top
;; スクリプトですので、使いやすいようにカスタマイズしてご利用ください。
;; スクリプトのまま使うこともできますが、AutoHotkey_L 付属の「Convert .ahk to .exe」
;; を使うと、exe ファイルに変換することができます。exe ファイルに変換することで、
;; AutoHotkey_L がインストールされていない PC でも Emacsキーバインドが利用可能
;; となります。

;; この内容は、utf-8-with-signature-dos の coding-system で ahk_emacs.ahk 等の名前で
;; セーブして利用してください。

;; Emacs の挙動と明らかに違う動きの部分は以下のとおりです。
;; ・ESC の二回押下で、ESC を入力できる。
;; ・C-o と C-\ で IME の切り替えが行われる。
;; ・C-k を連続して実行しても、クリップボードへの削除文字列の蓄積は行われない。
;; ・C-c、C-z は、Windows の「コピー」、「取り消し」が機能するようにしている。
;; ・C-x o は、一つ前にフォーカスがあったウインドウに移動する。
;;   NTEmacs から Windowsアプリケーションソフトを起動した際に戻るのに便利。
;; ・プレキー（ESC、C-x）は、その後にそのプレキーが意味を持つ後続キーが入力され
;;   なかった場合、状態が不定となる。（プレキーが有効となり続ける場合がある。）
;;   （実装を簡素にするため。C-g を押せば、無効となる。）
;; ・C-l は、アプリケーションソフト個別対応とする。recenter 関数で個別に指定すること。
;;   この設定では、Sakura Editor のみ対応している。
;; ・C-u には対応できていない。
;; ・キーボードマクロには対応していない。
;; ・Excel の場合、^Enter に F2（セル編集モード移行）を割り当てている。

#InstallKeybdHook
#UseHook

;; Emacs のキーバインドに"したくない"アプリケーションソフトを指定する
;; ・リターンコードが 0 の場合： 全てのキーバインドを有効とする
;; ・リターンコードが 1 の場合： 全てのキーバインドを無効とする
;; ・リターンコードが 2 の場合： input method の切り替えのみを有効とする
;; キーバインドの指定は、477行目（^\）と  648行目（^o）の辺りで行っている
;; ahk_class は、AutoHotKey_L 付属の「AutoIt3 Windows Spy」で確認できる
is_target()
{
        global

        if (WinActive("ahk_class ConsoleWindowClass")) { ; Cmd, Cygwin
                return 2
        }
        if (WinActive("ahk_class mintty")) { ; mintty
                return 2
        }
        if (WinActive("ahk_class Emacs")) { ; NTEmacs
                return 1
        }
        if (WinActive("ahk_class Vim")) { ; Vim
                return 2
        }
        if (WinActive("ahk_class PuTTY")) { ; PuTTY
                return 2
        }
        if (WinActive("ahk_class SWT_Window0")) { ; Eclipse
                return 2
        }
        if (WinActive("xyzzy")) { ; xyzzy
                return 2
        }

        if (is_c_q = 1) {
                is_c_q := 0
                return 1
        }
        else {
                return 0
        }
}

;; コマンドディレイを 0ms にする
SetKeyDelay 0

;; C-x が押されると1になる
is_c_x := 0

;; Escが押されると1になる
is_esc := 0

;; C-Space が押されると1になる
is_spc := 0

;; C-q が押されると1になる。
is_c_q := 0

;; プレキーの確認
get_pre_key()
{
        global
        if (is_c_x = 1) {
                is_c_x := 0
                return 1
        }
        if (is_esc = 1) {
                is_esc := 0
                return 2
        }
        return 0
}

;; IMEの切替え
toggle_input_method()
{
        Send {vkF3sc029}
}

;; ファイル操作
find_file()
{
        Send ^o
        global is_spc := 0
}
save_buffer()
{
        Send ^s
}
write_file()
{
        Send !fa
}

;; カーソル移動 
forward_char()
{
        global
        if (is_spc) {
                Send +{Right}
        }
        else {
                Send {Right}
        }
}
backward_char()
{
        global
        if (is_spc) {
                Send +{Left}
        }
        else {
                Send {Left}
        }
}
next_line()
{
        global
        if (is_spc) {
                Send +{Down}
        }
        else {
                Send {Down}
        }
}
previous_line()
{
        global
        if (is_spc) {
                Send +{Up}
        }
        else {
                Send {Up}
        }
}
move_beginning_of_line()
{
        global
        if (is_spc) {
                Send +{Home}
        }
        else {
                Send {Home}
        }
}
move_end_of_line()
{
        global
        if (is_spc) {
                if (WinActive("ahk_class OpusApp")) { ; Microsoft Word
                        Send +{End}+{Left}
                }
                else {
                        Send +{End}
                }
        }
        else {
                Send {End}
        }
}
beginning_of_buffer()
{
        global
        if (is_spc) {
                Send ^+{Home}
        }
        else {
                Send ^{Home}
        }
}
end_of_buffer()
{
        global
        if (is_spc) {
                Send ^+{End}
        }
        else {
                Send ^{End}
        }
}
scroll_up()
{
        global
        if (is_spc) {
                Send +{PgUp}
        }
        else {
                Send {PgUp}
        }
}
scroll_down()
{
        global
        if (is_spc) {
                Send +{PgDn}
        }
        else {
                Send {PgDn}
        }
}
recenter()
{
        if (WinActive("ahk_class TextEditorWindow")) { ; Sakura Editor
                Send ^h
        }
}

;; カット / コピー / 削除 / アンドゥ
delete_backward_char()
{
        Send {BS}
        global is_spc := 0
}
delete_char()
{
        Send {Del}
        global is_spc := 0
}
kill_line()
{
        global
        is_spc := 1
        move_end_of_line()
        Send ^c{Del}
        is_spc := 0
}
kill_region()
{
        Send ^x
        global is_spc := 0
}
kill_ring_save()
{
        Send ^c
        if (!WinActive("ahk_class XLMAIN")) { ; Microsoft Excel 以外
                Send {Esc}
        }
        global is_spc := 0
}
yank()
{
        Send ^v
        global is_spc := 0
}
undo()
{
        Send ^z
        global is_spc := 0
}
set_mark_command()
{
        global
        if (is_spc) {
                is_spc := 0
        }
        else {
                is_spc := 1
        }
}
mark_whole_buffer()
{
        Send ^{End}^+{Home}
        global is_spc := 1
}
mark_page()
{
        Send ^{End}^+{Home}
        global is_spc := 1
}
open_line()
{
        Send {Enter}{Up}{End}
        global is_spc := 0
}

;; バッファ / ウインドウ操作 
kill_buffer()
{
        Send ^{F4}
        global is_spc := 0
}
other_window()
{
        SetKeyDelay 10
        Send !{Tab}
        SetKeyDelay 0
        global is_spc := 0
}

;; 文字列検索 / 置換 
isearch_forward()
{
        Send ^f
        global is_spc := 0
}
isearch_backward()
{
        Send ^f
        global is_spc := 0
}

;; その他
newline()
{
        Send {Enter}
        global is_spc := 0
}
newline_and_indent()
{
        Send {Enter}{Tab}
        global is_spc := 0
}
indent_for_tab_command()
{
        Send {Tab}
        global is_spc := 0
}
quote_insert()
{
        global is_c_q := 1
}
keybord_quit()
{
        if (!WinActive("ahk_class XLMAIN")) { ; Microsoft Excel 以外
                Send {Esc}
        }
        global is_spc := 0
        global is_c_x := 0
        global is_esc := 0
}
kill_emacs()
{
        Send !{F4}
        global is_spc := 0
}

;; キーバインド
Esc::
        if (is_target()) {
                Send {%A_ThisHotkey%}
        }
        else {
                if (get_pre_key() = 2) {
                        Send {%A_ThisHotkey%}
                        is_esc := 0
                }
                else {
                        is_esc := 1
                }
        }
        return
^Space::
        if (is_target()) {
                Send {CtrlDown}{Space}{CtrlUp}
        }
        else {
                set_mark_command()
        }
        return
^/::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                undo()
        }
        return
<::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                if (get_pre_key() = 2) {
                        beginning_of_buffer()
                }
                else {
                        Send %A_ThisHotkey%
                }
        }
        return
!<::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                beginning_of_buffer()
        }
        return
>::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                if (get_pre_key() = 2) {
                        end_of_buffer()
                }
                else {
                        Send %A_ThisHotkey%
                }
        }
        return
!>::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                end_of_buffer()
        }
        return
^@::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                set_mark_command()
        }
        return
^[::
        if (is_target()) {
                Send {%A_ThisHotkey%}
        }
        else {
                if (get_pre_key() = 2) {
                        Send {Esc}
                        is_esc := 0
                }
                else {
                        is_esc := 1
                }
        }
        return
^\::
        if (is_target() = 1) {
                Send %A_ThisHotkey%
        }
        else {
                toggle_input_method()
        }
        return
^_::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                undo()
        }
        return
^a::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                move_beginning_of_line()
        }
        return
^b::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                backward_char()
        }
        return
^c::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                if (get_pre_key() = 1) {
                        kill_emacs()
                }
                else {
                        ; kill_ring_save()
                        Send %A_ThisHotkey%
                        is_spc := 0
                }
        }
        return
^d::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                delete_char()
        }
        return
^e::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                move_end_of_line()
        }
        return
^f::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                if (get_pre_key() = 1) {
                        find_file()
                }
                else {
                        forward_char()
                }
        }
        return
^g::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                keybord_quit()
        }
        return
h::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                if (get_pre_key() = 1) {
                        mark_whole_buffer()
                }
                else {
                        Send %A_ThisHotkey%
                }
        }
        return
^h::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                delete_backward_char()
        }
        return
^i::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                indent_for_tab_command()
        }
        return
^j::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                newline_and_indent()
        }
        return
k::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                if (get_pre_key() = 1) {
                        kill_buffer()
                }
                else {
                        Send %A_ThisHotkey%
                }
        }
        return
^k::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                kill_line()
        }
        return
^l::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                recenter()
        }
        return
^m::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                newline()
        }
        return
^n::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                next_line()
        }
        return
o::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                if (get_pre_key() = 1) {
                        other_window()
                }
                else {
                        Send %A_ThisHotkey%
                }
        }
        return
^o::
        if (is_target() = 1) {
                Send %A_ThisHotkey%
        }
        else {
                ; open_line()
                toggle_input_method()
        }
        return
^p::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                if (get_pre_key() = 1) {
                        mark_page()
                }
                else {
                        previous_line()
                }
        }
        return
^q::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                quote_insert()
        }
        return
^r::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                isearch_backward()
        }
        return
^s::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                if (get_pre_key() = 1) {
                        save_buffer()
                }
                else {
                        isearch_forward()
                }
        }
        return
u::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                if (get_pre_key() = 1) {
                        undo()
                }
                else {
                        Send %A_ThisHotkey%
                }
        }
        return
v::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                if (get_pre_key() = 2) {
                        scroll_up()
                }
                else {
                        Send %A_ThisHotkey%
                }
        }
        return
^v::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                scroll_down()
        }
        return
!v::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                scroll_up()
        }
        return
w::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                if (get_pre_key() = 2) {
                        kill_ring_save()
                }
                else {
                        Send %A_ThisHotkey%
                }
        }
        return
^w::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                if (get_pre_key() = 1) {
                        write_file()
                }
                else {
                        kill_region()
                }
        }
        return
!w::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                kill_ring_save()
        }
        return
^x::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                is_c_x := 1
        }
        return
^y::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                yank()
        }
        return
^z::
        if (is_target()) {
                Send %A_ThisHotkey%
        }
        else {
                undo()
        }
        return

;; for Excel
^Enter::
        if (is_target()) {
                Send {CtrlDown}{Enter}{CtrlUp}
        }
        else {
                if (WinActive("ahk_class XLMAIN")) { ; Microsoft Excel
                        Send {F2}
                }
                else {
                        Send {CtrlDown}{Enter}{CtrlUp}
                }
        }
        return