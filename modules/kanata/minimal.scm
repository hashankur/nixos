(defsrc
  esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12
  grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
  tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
  caps a    s    d    f    g    h    j    k    l    ;    '    ret
  lsft z    x    c    v    b    n    m    ,    .    /    rsft
  lctl lmet lalt           spc            ralt rmet rctl
)

(defalias
  cec (tap-hold 200 200 esc lctl)
  sym (tap-hold 200 200 f (layer-toggle symbols))
)

(deflayer default
  esc  f1   f2   f3   f4   f5   f6   f7   f8   f9   f10  f11  f12
  grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
  tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
  @cec a    s    d    @sym g    h    j    k    l    ;    '    ret
  lsft z    x    c    v    b    n    m    ,    .    /    rsft
  lctl lmet lalt           spc            ralt rmet rctl
)

(deflayer symbols
  _    _    _    _    _    _    _    _    _    _    _    _    _
  _    S-1  S-2  S-3  S-4  S-5  S-6  S-7  S-8  S-9  S-0  _    _    _
  _    S-5  S-6  S-7  S-8  _    _    _    _    S-9  S-0  esc  _    _
  _    _    _    del  _    _    left down up   rght _    _    _
  _    _    _    _    _    _    _    _    _    _    _    _
  _    _    _              _              _    _    _
)
