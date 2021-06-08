const charDict = {
    '0101': 0x2500,
    '0202': 0x2501,
    '1010': 0x2502,
    '2020': 0x2503,
    '0110': 0x250c,
    '0210': 0x250d,
    '0120': 0x250e,
    '0220': 0x250f,
    '0011': 0x2510,
    '0012': 0x2511,
    '0021': 0x2512,
    '0022': 0x2513,
    '1100': 0x2514,
    '1200': 0x2515,
    '2100': 0x2516,
    '2200': 0x2517,
    '1001': 0x2518,
    '1002': 0x2519,
    '2001': 0x251a,
    '2002': 0x251b,
    '1110': 0x251c,
    '1210': 0x251d,
    '2110': 0x251e,
    '1120': 0x251f,
    '2120': 0x2520,
    '2210': 0x2521,
    '1220': 0x2522,
    '2220': 0x2523,
    '1011': 0x2524,
    '1012': 0x2525,
    '2011': 0x2526,
    '1021': 0x2527,
    '2021': 0x2528,
    '2012': 0x2529,
    '1022': 0x252a,
    '2022': 0x252b,
    '0111': 0x252c,
    '0112': 0x252d,
    '0211': 0x252e,
    '0212': 0x252f,
    '0121': 0x2530,
    '0122': 0x2531,
    '0221': 0x2532,
    '0222': 0x2533,
    '1101': 0x2534,
    '1102': 0x2535,
    '1201': 0x2536,
    '1202': 0x2537,
    '2101': 0x2538,
    '2102': 0x2539,
    '2201': 0x253a,
    '2202': 0x253b,
    '1111': 0x253c,
    '1112': 0x253d,
    '1211': 0x253e,
    '1212': 0x253f,
    '2111': 0x2540,
    '1121': 0x2541,
    '2121': 0x2542,
    '2112': 0x2543,
    '2211': 0x2544,
    '1122': 0x2545,
    '1221': 0x2546,
    '2212': 0x2547,
    '1222': 0x2548,
    '2122': 0x2549,
    '2221': 0x254a,
    '2222': 0x254b,
    '0303': 0x2550,
    '3030': 0x2551,
    '0310': 0x2552,
    '0130': 0x2553,
    '0330': 0x2554,
    '0013': 0x2555,
    '0031': 0x2556,
    '0033': 0x2557,
    '1300': 0x2558,
    '3100': 0x2559,
    '3300': 0x255a,
    '1003': 0x255b,
    '3001': 0x255c,
    '3003': 0x255d,
    '1310': 0x255e,
    '3130': 0x255f,
    '3330': 0x2560,
    '1013': 0x2561,
    '3031': 0x2562,
    '3033': 0x2563,
    '0313': 0x2564,
    '0131': 0x2565,
    '0333': 0x2566,
    '1303': 0x2567,
    '3101': 0x2568,
    '3303': 0x2569,
    '1313': 0x256a,
    '3131': 0x256b,
    '3333': 0x256c,
    '0001': 0x2574,
    '1000': 0x2575,
    '0100': 0x2576,
    '0010': 0x2577,
    '0002': 0x2578,
    '2000': 0x2579,
    '0200': 0x257a,
    '0020': 0x257b,
    '0201': 0x257c,
    '1020': 0x257d,
    '0102': 0x257e,
    '2010': 0x257f
}

window.onload = function () {
    const pipeButtons = document.getElementsByClassName('pipeButton')
    for (let pipeButtonIndex = 0; pipeButtonIndex < pipeButtons.length; pipeButtonIndex++) {
        const pipeButton = pipeButtons[pipeButtonIndex]
        pipeButton.addEventListener('click', function () {
            this.setAttribute('state', (parseInt(this.getAttribute('state')) + 1) % 4)
            update()
        })
    }
}

function update() {
    const charOut = document.getElementById('charOut')
    const charCopy = document.getElementById('charCopy')
    const codeOut = document.getElementById('codeOut')
    const codeCopy = document.getElementById('codeCopy')

    const pb1State = document.getElementById('pb1').getAttribute('state')
    const pb2State = document.getElementById('pb2').getAttribute('state')
    const pb3State = document.getElementById('pb3').getAttribute('state')
    const pb4State = document.getElementById('pb4').getAttribute('state')

    const stateCode = `${pb1State}${pb2State}${pb3State}${pb4State}`
    if (stateCode in charDict) {
        const pipeCharCode = parseInt(charDict[stateCode])
        const pipeChar = String.fromCharCode(pipeCharCode)
        const pipeUnicode = `\\u${pipeCharCode.toString(16)}`

        charOut.innerText = pipeChar
        charCopy.onclick = function () { copyText(pipeChar) }
        codeOut.innerText = pipeUnicode
        codeCopy.onclick = function () { copyText(pipeUnicode) }

        return
    }

    charOut.innerText = 'Invalid'
    charCopy.onclick = function () {  }
    codeOut.innerText = 'N/A'
    codeCopy.onclick = function () {  }
}
