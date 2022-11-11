//
//  Dot3ViewModel.swift
//  spine
//
//  Created by Mac on 24/08/22.
//

import Foundation

class Dot3ViewModel: ObservableObject {
    @Published var showrReportSheet = false
    @Published var showSheet = false
    @Published var selectedReason = ""
    var tellUsMore = ""
}

let spamArray = ["Content is spam",
                 "Misleading title or content",
                 "Promotes harmful misinformation",
                 "Information is missing",
                 "Something else"
]

let inApprArray = ["Promotes illegal activity",
                   "Sexually explicit content",
                   "Promotes harmful misinformation",
                   "Intellectual property infrigement",
                   "Something else"
]

let hatefulArray = ["Promotes violent or criminal behaviour",
                    "Promotes hate speech or harassment",
                    "Promotes harmful misinformation",
                    "Something else"
]

let postedMsgArr = [ "Content is spam",
                     "Sexually explicit content",
                     "Promotes hate speech or harassment",
                     "Promotes violent or criminal behaviour",
                     "Harmful misinformation",
                     "Something else"
]

let inAproprPhoto = [ "Misleading title or content",
                      "Sexually explicit content",
                      "Promotes hate speech or harassment",
                      "Promotes violent or criminal behaviour",
                      "Intellectual property infringement",
                      "Something else"
]

let generalReportGuide = "The Spiritual Network considers any posts that are irrelevant, impersonal, unsolicited, promotional, or repetitive as spam. "
let userReportGuide = "The Spiritual Network considers any content sent to a member that is irrelevant, impersonal, unsolicited, promotional, or repetitive as spam. "
