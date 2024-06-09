//
//  CertificateListCell.swift
//  CarbonCerts
//
//  Created by Naomi on 09/06/2024.
//

import SwiftUI

struct CertificateListCell: View {
    let certificate: Certificate

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(Constants.Strings.UniqueID)
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text(certificate.id ?? Constants.Strings.CertNA)
                    .font(.system(<#T##style: Font.TextStyle##Font.TextStyle#>))
                    .foregroundColor(.secondary)
                Spacer()
                Image(systemName: certificate.isFavorited ? "bookmark.fill" : "bookmark")
                    .foregroundColor(.blue)
            }

            Text(Constants.Strings.Originator)
                .font(.subheadline)
                .fontWeight(.bold)
            Text(certificate.originator ?? Constants.Strings.DataNA)
                .font(.subheadline)
                .foregroundColor(.primary)

            Text(Constants.Strings.Owner)
                .font(.subheadline)
                .fontWeight(.bold)
            Text(certificate.owner ?? Constants.Strings.DataNA)
                .font(.subheadline)
                .foregroundColor(.primary)

            Text(certificate.status ?? Constants.Strings.DataNA)
                .font(.subheadline)
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal, 18)
        .padding(.vertical, 24)
    }
}

struct CertificateListCell_Previews: PreviewProvider {
    static var previews: some View {
        CertificateListCell(certificate: Certificate(id: "ES-159-b26e7328-b175-41ce-b4cd-49f7172a1d3d",
                                                     originator: "WEBPOINT JAKUB KRUPSKI ES",
                                                     originatorCountry: "Brasil",
                                                     owner: "WEBPOINT JAKUB KRUPSKI PL",
                                                     ownerCountry: "Brazil",
                                                     status: "Retired")
        )
    }
}
