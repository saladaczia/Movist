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
    let ad: Ad
    let ae, ar, at, au: AE
    let ba, bb: Ad
    let be, bg: AE
    let bh: Ad
    let bo, br: AE
    let bs: Ad
    let ca, ch: AE
    let ci: Ad
    let cl, co, cr, cz: AE
    let de, dk: AE
    let resultsDO, dz: Ad
    let ec, ee, eg, es: AE
    let fi, fr, gb: AE
    let gf, gh, gq: Ad
    let gr, gt, hk, hn: AE
    let hr, hu, id, ie: AE
    let il: Ad
    let resultsIN: AE
    let iq: Ad
    let resultsIS, it: AE
    let jm, jo: Ad
    let jp: AE
    let ke: Ad
    let kr: AE
    let kw, lb, li: Ad
    let lt, lv: AE
    let ly, ma, mc, md: Ad
    let mk, mt, mu: Ad
    let mx, my: AE
    let mz, ne, ng: Ad
    let nl, no, nz: AE
    let om, pa: Ad
    let pe: AE
    let pf: Ad
    let ph, pl: AE
    let ps: Ad
    let pt, py: AE
    let qa, ro, rs: Ad
    let ru, sa: AE
    let sc: Ad
    let se, sg, si, sk: AE
    let sm, sn, sv: Ad
    let th: AE
    let tn: Ad
    let tr: AE
    let tt: Ad
    let tw: AE
    let tz, ug: Ad
    let us: AE
    let uy: Ad
    let ve: AE
    let ye: Ad
    let za: AE
    let zm: Ad

    enum CodingKeys: String, CodingKey {
        case ad = "AD"
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
        case ci = "CI"
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
        case gh = "GH"
        case gq = "GQ"
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
        case ke = "KE"
        case kr = "KR"
        case kw = "KW"
        case lb = "LB"
        case li = "LI"
        case lt = "LT"
        case lv = "LV"
        case ly = "LY"
        case ma = "MA"
        case mc = "MC"
        case md = "MD"
        case mk = "MK"
        case mt = "MT"
        case mu = "MU"
        case mx = "MX"
        case my = "MY"
        case mz = "MZ"
        case ne = "NE"
        case ng = "NG"
        case nl = "NL"
        case no = "NO"
        case nz = "NZ"
        case om = "OM"
        case pa = "PA"
        case pe = "PE"
        case pf = "PF"
        case ph = "PH"
        case pl = "PL"
        case ps = "PS"
        case pt = "PT"
        case py = "PY"
        case qa = "QA"
        case ro = "RO"
        case rs = "RS"
        case ru = "RU"
        case sa = "SA"
        case sc = "SC"
        case se = "SE"
        case sg = "SG"
        case si = "SI"
        case sk = "SK"
        case sm = "SM"
        case sn = "SN"
        case sv = "SV"
        case th = "TH"
        case tn = "TN"
        case tr = "TR"
        case tt = "TT"
        case tw = "TW"
        case tz = "TZ"
        case ug = "UG"
        case us = "US"
        case uy = "UY"
        case ve = "VE"
        case ye = "YE"
        case za = "ZA"
        case zm = "ZM"
    }
}

// MARK: - Ad
struct Ad: Codable {
    let link: String
    let flatrate: [Flatrate]
}

// MARK: - Flatrate
struct Flatrate: Codable {
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

// MARK: - AE
struct AE: Codable {
    let link: String
    let buy: [Flatrate]
    let flatrate, rent, free: [Flatrate]?
}

