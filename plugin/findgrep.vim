" This is based roughly on ack.vim, by Miles Sterrett and geekQ, and
" originally based on a blog post by Antoine Imbert.
"
" If you like ack, use it!  I wrote this because grep is significantly faster
" than ack on my machine.
"
" To use this plugin, either call the functions defined at the bottom of the
" file directly, as in
"
"   :SearchIdl nsDocShell
"
" or define a shortcut in your vimrc.  For instance,
"
"   noremap <leader>f :SearchAll
"
" (You'll probably want a space at the end of that line.)
"
" If you call one of these functions without an explicit argument, it will
" search for the word under your cursor.
"
" You can also pass arguments straight to grep.  For instance, to do a
" case-insensitive search over headers, run
"
"   :SearchH -i CrAzYCaPs
"


function! Search(suffix, args)
  " Set A mark so we can get back to where we were.
  mark A

  redraw

  " Files we don't want to match on.
  let l:excludes =
\     '-name .git -or ' .
\     '-name *.swp -or ' .
\     '-name *.log -or ' .
\     '-name tags'

  if empty(a:args)
    let l:grepargs = expand("<cword>")
  else
    let l:grepargs = a:args
  endif

  let l:old_grepprg = &grepprg
  try
    " Leave a parenthesis hanging open so we can append the suffix clause if
    " necessary.
    let l:find = 'find . \( -name ''.?*'' -prune \) -or \( -not \( '.l:excludes.' \)'

    if a:suffix != ''
      let l:find = l:find . " -and \\( -name '" . a:suffix . "' \\)"
    endif

    " Close our hanging parenthesis.
    let l:find = l:find . ' -print0 \)'

    let &grepprg = l:find. ' \| xargs -P 8 -0 grep -In $*'
    silent execute "grep" l:grepargs
  finally
    let &grepprg = l:old_grepprg
  endtry

  botright copen

  redraw!
endfunction

command! -nargs=* SearchAll      :call Search('*',   <q-args>)
command! -nargs=* SearchRb       :call Search('*.rb', <q-args>)
command! -nargs=* SearchErb      :call Search('*.erb', <q-args>)
command! -nargs=* SearchRails    :call Search("*.rb' -or -name '*.erb' -or -name '*.rake", <q-args>)
command! -nargs=* SearchYml      :call Search('*.yml', <q-args>)

