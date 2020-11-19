echo ls

(echo ls) # same as `echo ls`

$(echo ls) # same as `ls`

echo (echo ls) # fails bc tries to interpret glob pattern?

echo $(echo ls) # == `echo ls`

{ echo ls } # == `echo ls`

echo { echo ls } # ERROR: zsh: parse error near `}'

echo ${ echo ls } # ERROR: zsh: bad substitution