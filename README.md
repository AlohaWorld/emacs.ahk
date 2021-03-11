# Emacs Key Bingings for Windows 
This script allows you to use the emacs-like key bindings on Windows, which is written in AutoHotkey (AHK) language. 

This script develops based upon [[usi3/emacs.ahk][https://github.com/usi3/emacs.ahk]] project. 

## Installations

1. Download Auto Hot Key v2 (Alpha) @ https://www.autohotkey.com/
2. Unpack the zip file to a folder, say, C:\Program Files\AutoHotKey
3. Clone or download this repository
4. Double click on EmacsKB.ahk2 and use "C:\Program Files\AutoHotKey\AutoHotkeyU64.exe" to open this .ahk2 file
5. Enjoy Emacs Key Binding on windows

## Supported keybindings

<table>
  <tr>
    <th>Keybinding</th>
    <th>Emacs Lisp Function</th>
  </tr>
<tr>
<td>C-Space</td>
<td>set-mark-command</td>
</tr>
<tr>
<td>C-@</td>
<td>set-mark-command</td>
</tr>
<tr>
<td>C-x C-f</td>
<td>find-file</td>
</tr>
<tr>
<td>C-x C-s</td>
<td>save-buffer</td>
</tr>
<tr>
<td>C-x C-c</td>
<td>kill-emacs / close current application</td>
</tr>
<tr>
<td>C-x k</td>
<td>kill-buffer / kill current tab (in chrome, etc.) </td>
</tr>
<tr>
<td>C-x h</td>
<td>mark-whole-buffer / select all </td>
</tr>
<tr>
<td>C-d</td>
<td>delete-char</td>
</tr>
<tr>
<td>M-d</td>
<td>delete-word</td>
</tr>
<tr>
<td>C-h</td>
<td>delete-backward-char</td>
</tr>
<tr>
<td>C-k</td>
<td>kill-line</td>
</tr>
<tr>
<td>C-o</td>
<td>other window / swith to next tab page</td>
</tr>
<tr>
<td>C-g</td>
<td>quit</td>
</tr>
<tr>
<td>C-j</td>
<td>newline-and-indent</td>
</tr>
<tr>
<td>C-m</td>
<td>newline</td>
</tr>
<tr>
<td>C-i</td>
<td>indent-for-tab-command</td>
</tr>
<tr>
<td>C-s</td>
<td>isearch-forward</td>
</tr>
<tr>
<td>C-r</td>
<td>isearch-backward</td>
</tr>
<tr>
<td>C-w</td>
<td>kill-region</td>
</tr>
<tr>
<td>M-w</td>
<td>kill-ring-save</td>
</tr>
<tr>
<td>C-y</td>
<td>yank</td>
</tr>
<tr>
<td>C-/</td>
<td>undo</td>
</tr>
<tr>
<td>C-a</td>
<td>move-beginning-of-line</td>
</tr>
<tr>
<td>C-e</td>
<td>move-end-of-line</td>
</tr>
<tr>
<td>C-p</td>
<td>previous-line</td>
</tr>
<tr>
<td>C-n</td>
<td>next-line</td>
</tr>
<tr>
<td>C-f</td>
<td>forward-char</td>
</tr>
<tr>
<td>M-f</td>
<td>forward-word</td>
</tr>    
<tr>
<td>C-b</td>
<td>backward-char</td>
</tr>
<tr>
<td>M-b</td>
<td>backward-word</td>
</tr>
<tr>
<td>C-v</td>
<td>scroll-down</td>
</tr>
<tr>
<td>M-v</td>
<td>scroll-up</td>
</tr>
</table>






## Some webpages that introduced this script
* [AutoHotkeyでemacs風キーバインド - torutkの日記](http://d.hatena.ne.jp/torutk/20101009/p2)
* [オダろぐ : Emacs＞AutoHotKey の Emacsモードを使うことにした](http://blog.livedoor.jp/odaxsen/archives/1546840.html)
* [AutoHotkey &laquo; sea side she side](http://www.a10i.jp/?tag=autohotkey)
* [NTEmacs @ ウィキ - Windows の操作を emacs のキーバインドで行う設定 （AutoHotKey版）](http://www49.atwiki.jp/ntemacs/pages/20.html)
    * Customized by 2cher
