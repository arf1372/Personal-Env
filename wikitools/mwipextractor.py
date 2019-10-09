#!/usr/bin/env python3
#-*- encoding: utf-8 -*-

import sys

import requests as req
import lxml.etree as et

MW_IP_PAGE="https://wikitech.wikimedia.org/wiki/IP_and_AS_allocations"

def main():
    res = req.get(MW_IP_PAGE)
    if res.ok:
        elem = et.fromstring(res.text)
    else:
        print("ERROR in downloading MediaWiki's netblocks page!!!", file=sys.stderr)
        raise Exception("Can't download MediaWiki's Netblocks page")
    ip_list = [ip.strip() for ip in elem.xpath("//table[1]//tr/td[2]/text()")]

    for ip in ip_list:
        print(ip)

if __name__ == "__main__":
    main()
