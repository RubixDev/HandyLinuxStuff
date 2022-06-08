xkb_symbols "us_de" {

    include "us(basic)"
    include "eurosign(e)"

    name[Group1]= "QWERTY with german Umlaut keys";

    key <AC01> {[ a,          A,           adiaeresis,    Adiaeresis     ]};
    key <AD09> {[ o,          O,           odiaeresis,    Odiaeresis     ]};
    key <AC02> {[ s,          S,           ssharp,        U1E9E          ]};
    key <AD07> {[ u,          U,           udiaeresis,    Udiaeresis     ]};
    key <AB07> {[ m,          M,           mu                            ]};


    key <TLDE> {[ grave,      asciitilde,  degree                        ]};
    key <AE01> {[ 1,          exclam,      onesuperior                   ]};
    key <AE02> {[ 2,          at,          twosuperior                   ]};
    key <AE03> {[ 3,          numbersign,  threesuperior                 ]};
    key <AE04> {[ 4,          dollar,      foursuperior,  sterling       ]};
    key <AE05> {[ 5,          percent,     fivesuperior                  ]};
    key <AE06> {[ 6,          asciicircum, sixsuperior                   ]};
    key <AE07> {[ 7,          ampersand,   sevensuperior                 ]};
    key <AE08> {[ 8,          asterisk,    eightsuperior                 ]};
    key <AE09> {[ 9,          parenleft,   ninesuperior                  ]};
    key <AE10> {[ 0,          parenright,  zerosuperior                  ]};
    key <AE12> {[ equal,      plus,        multiply,      division       ]};

    key <AB08> {[ comma,      less,        U2039,         guillemotleft  ]};
    key <AB09> {[ period,     greater,     U203A,         guillemotright ]};

    key <BKSL> {[ backslash,  bar,         brokenbar                     ]};
    key <LSGT> {[ backslash,  bar,         brokenbar                     ]};

    modifier_map Mod3   { Scroll_Lock };
    include "level3(ralt_switch)"
};
