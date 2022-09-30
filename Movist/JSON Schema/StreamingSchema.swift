//
//  StreamingSchema.swift
//  Movist
//
//  Created by Maciej Sołoducha on 30/09/2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome {
    let id: Int
    let results: Results
}

// MARK: - Results
struct Results {
    let ae, ar, at, au: AE
    let ba, bb: Ba
    let be, bg: AE
    let bh: Ba
    let bo, br: AE
    let bs: Ba
    let ca, ch, cl, co: AE
    let cr, cz, de, dk: AE
    let resultsDO, dz: Ba
    let ec, ee, eg, es: AE
    let fi, fr, gb: AE
    let gf: Ba
    let gr, gt, hk, hn: AE
    let hr, hu, id, ie: AE
    let il: Ba
    let resultsIN: AE
    let iq: Ba
    let resultsIS, it: AE
    let jm, jo: Ba
    let jp, kr: AE
    let kw, lb: Ba
    let lt, lv: AE
    let ly, ma, md: Ba
    let mx, my, nl, no: AE
    let nz: AE
    let om, pa: Ba
    let pe, ph, pl: AE
    let ps: Ba
    let pt, py: AE
    let qa, ro: Ba
    let ru, sa, se, sg: AE
    let sk: AE
    let sm, sv: Ba
    let th: AE
    let tn: Ba
    let tr: AE
    let tt: Ba
    let tw, us: AE
    let uy, va: Ba
    let ve: AE
    let ye: Ba
    let za: AE
}

// MARK: - AE
struct AE {
    let link: String
    let flatrate: [Buy]?
    let rent, buy: [Buy]
    let free: [Buy]?
}

// MARK: - Buy
struct Buy {
    let logoPath: String
    let providerID: Int
    let providerName: String
    let displayPriority: Int
}

// MARK: - Ba
struct Ba {
    let link: String
    let flatrate: [Buy]
}

