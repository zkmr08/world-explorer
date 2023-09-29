//
//  WECountryCurrencies.swift
//  World Explorer
//
//  Created by Zakaria Marouf on 23/09/23.
//

import Foundation

struct Currencies: Codable {
    let usd, bwp, uyu, mkd: Aed?
    let eur, bgn, pgk, pkr: Aed?
    let ern, dkk, mmk, mop: Aed?
    let aud, tvd, sos, rsd: Aed?
    let mur, shp, xcd, amd: Aed?
    let ttd, kid, xof, vnd: Aed?
    let sgd, bnd, gbp, imp: Aed?
    let crc, clp, top, zar: Aed?
    let ang, ghs, mwk, kyd: Aed?
    let xaf, gel, gmd, nok: Aed?
    let kes, bdt, bbd, kmf: Aed?
    let iqd, khr, pyg, hkd: Aed?
    let fjd, tnd, syp, cdf: Aed?
    let kwd, currenciesTRY, lak, sar: Aed?
    let egp, ils, jod, ggp: Aed?
    let mnt, btn, inr, kzt: Aed?
    let ssp, nzd, myr, hnl: Aed?
    let jmd, brl, bhd, ars: Aed?
    let gnf, pab, xpf, bsd: Aed?
    let tjs, all, scr, kgs: Aed?
    let vuv, dzd, mad, mru: Aed?
    let bzd, aed, idr, stn: Aed?
    let chf, cad, cny, lyd: Aed?
    let ves, cop, pen, mdl: Aed?
    let lsl, gtq, sbd, lrd: Aed?
    let php, huf, omr, bob: Aed?
    let irr, djf, fkp, yer: Aed?
    let gip, mvr, sll: Aed?
    let sdg: BAM?
    let afn, czk, srd, mxn: Aed?
    let ron, zwl, thb, gyd: Aed?
    let tmt, nio, azn, cuc: Aed?
    let cup, awg, mzn, zmw: Aed?
    let jpy, aoa: Aed?
    let bam: BAM?
    let sek, lkr, tzs, mga: Aed?
    let krw, rub, ngn, fok: Aed?
    let uah, bmd, twd, byn: Aed?
    let ckd, lbp, htg, dop: Aed?
    let uzs, cve, rwf, szl: Aed?
    let bif, kpw, ugx, npr: Aed?
    let isk, jep, nad, qar: Aed?
    let pln, wst, etb: Aed?

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case bwp = "BWP"
        case uyu = "UYU"
        case mkd = "MKD"
        case eur = "EUR"
        case bgn = "BGN"
        case pgk = "PGK"
        case pkr = "PKR"
        case ern = "ERN"
        case dkk = "DKK"
        case mmk = "MMK"
        case mop = "MOP"
        case aud = "AUD"
        case tvd = "TVD"
        case sos = "SOS"
        case rsd = "RSD"
        case mur = "MUR"
        case shp = "SHP"
        case xcd = "XCD"
        case amd = "AMD"
        case ttd = "TTD"
        case kid = "KID"
        case xof = "XOF"
        case vnd = "VND"
        case sgd = "SGD"
        case bnd = "BND"
        case gbp = "GBP"
        case imp = "IMP"
        case crc = "CRC"
        case clp = "CLP"
        case top = "TOP"
        case zar = "ZAR"
        case ang = "ANG"
        case ghs = "GHS"
        case mwk = "MWK"
        case kyd = "KYD"
        case xaf = "XAF"
        case gel = "GEL"
        case gmd = "GMD"
        case nok = "NOK"
        case kes = "KES"
        case bdt = "BDT"
        case bbd = "BBD"
        case kmf = "KMF"
        case iqd = "IQD"
        case khr = "KHR"
        case pyg = "PYG"
        case hkd = "HKD"
        case fjd = "FJD"
        case tnd = "TND"
        case syp = "SYP"
        case cdf = "CDF"
        case kwd = "KWD"
        case currenciesTRY = "TRY"
        case lak = "LAK"
        case sar = "SAR"
        case egp = "EGP"
        case ils = "ILS"
        case jod = "JOD"
        case ggp = "GGP"
        case mnt = "MNT"
        case btn = "BTN"
        case inr = "INR"
        case kzt = "KZT"
        case ssp = "SSP"
        case nzd = "NZD"
        case myr = "MYR"
        case hnl = "HNL"
        case jmd = "JMD"
        case brl = "BRL"
        case bhd = "BHD"
        case ars = "ARS"
        case gnf = "GNF"
        case pab = "PAB"
        case xpf = "XPF"
        case bsd = "BSD"
        case tjs = "TJS"
        case all = "ALL"
        case scr = "SCR"
        case kgs = "KGS"
        case vuv = "VUV"
        case dzd = "DZD"
        case mad = "MAD"
        case mru = "MRU"
        case bzd = "BZD"
        case aed = "AED"
        case idr = "IDR"
        case stn = "STN"
        case chf = "CHF"
        case cad = "CAD"
        case cny = "CNY"
        case lyd = "LYD"
        case ves = "VES"
        case cop = "COP"
        case pen = "PEN"
        case mdl = "MDL"
        case lsl = "LSL"
        case gtq = "GTQ"
        case sbd = "SBD"
        case lrd = "LRD"
        case php = "PHP"
        case huf = "HUF"
        case omr = "OMR"
        case bob = "BOB"
        case irr = "IRR"
        case djf = "DJF"
        case fkp = "FKP"
        case yer = "YER"
        case gip = "GIP"
        case mvr = "MVR"
        case sll = "SLL"
        case sdg = "SDG"
        case afn = "AFN"
        case czk = "CZK"
        case srd = "SRD"
        case mxn = "MXN"
        case ron = "RON"
        case zwl = "ZWL"
        case thb = "THB"
        case gyd = "GYD"
        case tmt = "TMT"
        case nio = "NIO"
        case azn = "AZN"
        case cuc = "CUC"
        case cup = "CUP"
        case awg = "AWG"
        case mzn = "MZN"
        case zmw = "ZMW"
        case jpy = "JPY"
        case aoa = "AOA"
        case bam = "BAM"
        case sek = "SEK"
        case lkr = "LKR"
        case tzs = "TZS"
        case mga = "MGA"
        case krw = "KRW"
        case rub = "RUB"
        case ngn = "NGN"
        case fok = "FOK"
        case uah = "UAH"
        case bmd = "BMD"
        case twd = "TWD"
        case byn = "BYN"
        case ckd = "CKD"
        case lbp = "LBP"
        case htg = "HTG"
        case dop = "DOP"
        case uzs = "UZS"
        case cve = "CVE"
        case rwf = "RWF"
        case szl = "SZL"
        case bif = "BIF"
        case kpw = "KPW"
        case ugx = "UGX"
        case npr = "NPR"
        case isk = "ISK"
        case jep = "JEP"
        case nad = "NAD"
        case qar = "QAR"
        case pln = "PLN"
        case wst = "WST"
        case etb = "ETB"
    }
}

// MARK: - Aed
struct Aed: Codable {
    let name, symbol: String
}

// MARK: - BAM
struct BAM: Codable {
    let name: String
}
