let brailleCode = '00000000'

window.onload = function () {
    const cbs = document.getElementById('checkboxContainer').children
    for (let cbIndex = 0; cbIndex < cbs.length; cbIndex++) {
        const cb = cbs[cbIndex]
        cb.firstChild.addEventListener('input', function () {
            const index = parseInt(this.id.slice(-1))
            const replacment = this.checked ? '1' : '0'
            brailleCode = brailleCode.replaceAt(index - 1, replacment)
            update()
        })
    }
    update()
}

String.prototype.replaceAt = function(index, replacement) {
    return this.substr(0, index) + replacement + this.substr(index + replacement.length);
}

String.prototype.reverse = function () {
    return this.split("").reverse().join("")
}

function update() {
    const brailleCharCode = parseInt(brailleCode.reverse(), 2) + 0x2800
    const brailleChar = String.fromCharCode(brailleCharCode)
    const brailleUnicode = `\\u${brailleCharCode.toString(16)}`

    const charOut = document.getElementById('charOut')
    const charCopy = document.getElementById('charCopy')
    const codeOut = document.getElementById('codeOut')
    const codeCopy = document.getElementById('codeCopy')

    charOut.innerText = brailleChar
    charCopy.onclick = function () { copyText(brailleChar) }
    codeOut.innerText = brailleUnicode
    codeCopy.onclick = function () { copyText(brailleUnicode) }
}
