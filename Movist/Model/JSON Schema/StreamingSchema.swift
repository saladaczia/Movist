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
struct StreamingSchema: Codable {
    let id: Int
    let results: StreamingResults
}

// MARK: - Results
struct StreamingResults: Codable {
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

    enum CodingKeys: String, CodingKey {
        case ae = "AE"
        case ar = "AR"
        case at = "AT"
        case au = "AU"
        case ba = "BA"
        case bb = "BB"
        case be = "BE"
        case bg = "BG"
        case bh = "BH"
        case bo = "BO"
        case br = "BR"
        case bs = "BS"
        case ca = "CA"
        case ch = "CH"
        case cl = "CL"
        case co = "CO"
        case cr = "CR"
        case cz = "CZ"
        case de = "DE"
        case dk = "DK"
        case resultsDO = "DO"
        case dz = "DZ"
        case ec = "EC"
        case ee = "EE"
        case eg = "EG"
        case es = "ES"
        case fi = "FI"
        case fr = "FR"
        case gb = "GB"
        case gf = "GF"
        case gr = "GR"
        case gt = "GT"
        case hk = "HK"
        case hn = "HN"
        case hr = "HR"
        case hu = "HU"
        case id = "ID"
        case ie = "IE"
        case il = "IL"
        case resultsIN = "IN"
        case iq = "IQ"
        case resultsIS = "IS"
        case it = "IT"
        case jm = "JM"
        case jo = "JO"
        case jp = "JP"
        case kr = "KR"
        case kw = "KW"
        case lb = "LB"
        case lt = "LT"
        case lv = "LV"
        case ly = "LY"
        case ma = "MA"
        case md = "MD"
        case mx = "MX"
        case my = "MY"
        case nl = "NL"
        case no = "NO"
        case nz = "NZ"
        case om = "OM"
        case pa = "PA"
        case pe = "PE"
        case ph = "PH"
        case pl = "PL"
        case ps = "PS"
        case pt = "PT"
        case py = "PY"
        case qa = "QA"
        case ro = "RO"
        case ru = "RU"
        case sa = "SA"
        case se = "SE"
        case sg = "SG"
        case sk = "SK"
        case sm = "SM"
        case sv = "SV"
        case th = "TH"
        case tn = "TN"
        case tr = "TR"
        case tt = "TT"
        case tw = "TW"
        case us = "US"
        case uy = "UY"
        case va = "VA"
        case ve = "VE"
        case ye = "YE"
        case za = "ZA"
    }
}

// MARK: - AE
struct AE: Codable {
    let link: String
    let flatrate: [Buy]?
    let rent, buy: [Buy]
    let free: [Buy]?
}

// MARK: - Buy
struct Buy: Codable {
    let logoPath: String
    let providerID: Int
    let providerName: String
    let displayPriority: Int

    enum CodingKeys: String, CodingKey {
        case logoPath = "logo_path"
        case providerID = "provider_id"
        case providerName = "provider_name"
        case displayPriority = "display_priority"
    }
}

// MARK: - Ba
struct Ba: Codable {
    let link: String
    let flatrate: [Buy]
}
