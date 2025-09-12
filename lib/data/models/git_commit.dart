

import '../../common_libraries.dart';

class GitCommit extends Equatable {
  final String sha;
  final String nodeId;
  final CommitDetail? commit;
  final String url;
  final String htmlUrl;
  final String commentsUrl;
  final GitUser? author;
  final GitUser? committer;
  final List<Parent> parents;

   GitCommit({
    this.sha = '',
    this.nodeId = '',
    this.commit ,
    this.url = '',
    this.htmlUrl = '',
    this.commentsUrl = '',
    this.author,
    this.committer,
    this.parents = const [],
  });

  factory GitCommit.fromJson(Map<String, dynamic> json) {
    return GitCommit(
      sha: json['sha'] ?? '',
      nodeId: json['node_id'] ?? '',
      commit: json['commit'] != null ? CommitDetail.fromJson(json['commit']) :  CommitDetail(),
      url: json['url'] ?? '',
      htmlUrl: json['html_url'] ?? '',
      commentsUrl: json['comments_url'] ?? '',
      author: json['author'] != null ? GitUser.fromJson(json['author']) : null,
      committer: json['committer'] != null ? GitUser.fromJson(json['committer']) : null,
      parents: json['parents'] != null
          ? List<Parent>.from(json['parents'].map((x) => Parent.fromJson(x)))
          : [],
    );
  }



  GitCommit copyWith({
    String? sha,
    String? nodeId,
    CommitDetail? commit,
    String? url,
    String? htmlUrl,
    String? commentsUrl,
    GitUser? author,
    GitUser? committer,
    List<Parent>? parents,
  }) {
    return GitCommit(
      sha: sha ?? this.sha,
      nodeId: nodeId ?? this.nodeId,
      commit: commit ?? this.commit,
      url: url ?? this.url,
      htmlUrl: htmlUrl ?? this.htmlUrl,
      commentsUrl: commentsUrl ?? this.commentsUrl,
      author: author ?? this.author,
      committer: committer ?? this.committer,
      parents: parents ?? this.parents,
    );
  }

  @override
  List<Object?> get props => [sha, nodeId, commit, url, htmlUrl, commentsUrl, author, committer, parents];
}

class CommitDetail extends Equatable {
  final CommitAuthor? author;
  final CommitAuthor? committer;
  final String message;
  final Tree tree;
  final String url;
  final int commentCount;
  final Verification verification;

    CommitDetail({
    this.author ,
    this.committer ,
    this.message = '',
    this.tree = const Tree(),
    this.url = '',
    this.commentCount = 0,
    this.verification = const Verification(),
  });

  factory CommitDetail.fromJson(Map<String, dynamic> json) {
    return CommitDetail(
      author: json['author'] != null ? CommitAuthor.fromJson(json['author']) :  CommitAuthor(),
      committer: json['committer'] != null ? CommitAuthor.fromJson(json['committer']) :  CommitAuthor(),
      message: json['message'] ?? '',
      tree: json['tree'] != null ? Tree.fromJson(json['tree']) : const Tree(),
      url: json['url'] ?? '',
      commentCount: json['comment_count'] ?? 0,
      verification: json['verification'] != null ? Verification.fromJson(json['verification']) : const Verification(),
    );
  }



  @override
  List<Object?> get props => [author, committer, message, tree, url, commentCount, verification];
}

class CommitAuthor extends Equatable {
  final String name;
  final String email;
  final DateTime date;

   CommitAuthor({
    this.name = '',
    this.email = '',
    DateTime? date,
  }) : date = date ?? DateTime.now();

  factory CommitAuthor.fromJson(Map<String, dynamic> json) {
    return CommitAuthor(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      date: json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'date': date.toIso8601String()};
  }

  @override
  List<Object?> get props => [name, email, date];
}

class Tree extends Equatable {
  final String sha;
  final String url;

  const Tree({this.sha = '', this.url = ''});

  factory Tree.fromJson(Map<String, dynamic> json) {
    return Tree(
      sha: json['sha'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'sha': sha, 'url': url};

  @override
  List<Object?> get props => [sha, url];
}

class Verification extends Equatable {
  final bool verified;
  final String reason;
  final String? signature;
  final String? payload;
  final DateTime? verifiedAt;

  const Verification({
    this.verified = false,
    this.reason = '',
    this.signature,
    this.payload,
    this.verifiedAt,
  });

  factory Verification.fromJson(Map<String, dynamic> json) {
    return Verification(
      verified: json['verified'] ?? false,
      reason: json['reason'] ?? '',
      signature: json['signature'],
      payload: json['payload'],
      verifiedAt: json['verified_at'] != null ? DateTime.parse(json['verified_at']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'verified': verified,
    'reason': reason,
    'signature': signature,
    'payload': payload,
    'verified_at': verifiedAt?.toIso8601String(),
  };

  @override
  List<Object?> get props => [verified, reason, signature, payload, verifiedAt];
}



class Parent extends Equatable {
  final String sha;
  final String url;
  final String htmlUrl;

  const Parent({this.sha = '', this.url = '', this.htmlUrl = ''});

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
      sha: json['sha'] ?? '',
      url: json['url'] ?? '',
      htmlUrl: json['html_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'sha': sha, 'url': url, 'html_url': htmlUrl};

  @override
  List<Object?> get props => [sha, url, htmlUrl];
}
