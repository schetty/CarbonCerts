//
//  CertificateListCell.swift
//  CarbonCerts
//
//  Created by Naomi on 09/06/2024.
//

import SwiftUI
import SwiftData

struct CertificateListCell: View {
    var context: ModelContext
    let certificate: Certificate
    
    init(context: ModelContext, certificate: Certificate) {
        self.context = context
        self.certificate = certificate
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Constants.Strings.UniqueID)
                .font(.subheadline)
                .fontWeight(.bold)
                .lineLimit(0)
            Text(certificate.id ?? Constants.Strings.CertNA)
                .font(Font.custom("Courier", size: 14.0))
                .foregroundColor(.secondary)
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
        }.padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .overlay(
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        certificate.isFavorited.toggle()
                    }) {
                        Image(systemName: certificate.isFavorited ? "bookmark.fill" : "bookmark")
                            .foregroundColor(.blue)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30))
                    }
                }
                Spacer()
            }
        )
    }
    
    private func saveContext() {
           do {
               try context.save()
           } catch {
               print("Failed to save context: \(error)")
           }
       }
}

