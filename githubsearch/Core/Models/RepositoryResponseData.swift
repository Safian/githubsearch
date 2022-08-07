//
//  RepositoryClientData.swift
//  githubsearch
//
//  Created by Szabolcs Sáfián on 2022. 08. 06..
//

import Foundation

public struct RepositoryResponseData: Codable {

    let id: Int
    let nodeId: String?
    let name: String
    let fullName: String?
    let itemPrivate: Bool?
    let owner: Owner
    let htmlUrl: String?
    let description: String?
//    let fork: Bool
//    let url: String
//    let forksUrl: String
//    let keysUrl, collaboratorsUrl: String
//    let teamsUrl, hooksUrl: String
//    let issueEventsUrl: String
//    let eventsUrl: String
//    let assigneesUrl: String
//    let branchesUrl: String
//    let tagsUrl: String
//    let blobsUrl, gitTagsUrl, gitRefsUrl, treesUrl: String
//    let statusesUrl: String
//    let languagesUrl, stargazersUrl, contributorsUrl, subscribersUrl: String
//    let subscriptionUrl: String
//    let commitsUrl, gitCommitsUrl, commentsUrl, issueCommentUrl: String
//    let contentsUrl, compareUrl: String
//    let mergesUrl: String
//    let archiveUrl: String
//    let downloadsUrl: String
//    let issuesUrl, pullsUrl, milestonesUrl, notificationsUrl: String
//    let labelsUrl, releasesUrl: String
//    let deploymentsUrl: String
    let createdAt:Date
    let updatedAt: Date
    let pushedAt: Date?
//    let gitUrl, sshUrl: String
//    let cloneUrl: String
//    let svnUrl: String
//    let homepage: String?
//    let size, stargazersCount, watchersCount: Int
    let language: String?
//    let hasIssues, hasProjects, hasDownloads, hasWiki: Bool
//    let hasPages: Bool
//    let forksCount: Int
//    let mirrorUrl: String?
//    let archived, disabled: Bool
//    let openIssuesCount: Int
//    let license: String?
//    let allowForking, isTemplate, webCommitSignoffRequired: Bool
//    let topics: [String]
//    let visibility: Visibility
//    let forks, openIssues, watchers: Int
//    let defaultBranch: String
    let score: Int

}

public enum Visibility: String, Codable {
    case isPublic = "public"
    case isPrivate = "private"
}

// MARK: - Owner

public struct Owner: Codable {
    let login: String
    let id: Int
    let nodeId: String
    let avatarUrl: String
    let gravatarId: String
    let url, htmlUrl, followersUrl: String?
    let followingUrl:String?
    let gistsUrl, starredUrl: String?
    let subscriptionsUrl, organizationsUrl, reposUrl: String?
    let eventsUrl: String?
    let receivedEventsUrl: String?
    let type: TypeEnum
    let siteAdmin: Bool?
}

public enum TypeEnum: String, Codable {
    case organization = "Organization"
    case user = "User"
}
