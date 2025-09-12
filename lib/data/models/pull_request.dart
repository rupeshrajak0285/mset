
import '../../common_libraries.dart';

class PullRequest extends Equatable {
  final int id;
  final int number;
  final String title;
  final String state;
  final String url;
  final String htmlUrl;
  final String body;
  final String createdAt;
  final String updatedAt;
  final String? closedAt;
  final String? mergedAt;
  final GitUser user;

  const PullRequest({
    this.id = 0,
    this.number = 0,
    this.title = '',
    this.state = '',
    this.url = '',
    this.htmlUrl = '',
    this.body = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.closedAt,
    this.mergedAt,
    this.user = const GitUser(),
  });

  factory PullRequest.fromJson(Map<String, dynamic> json) {
    return PullRequest(
      id: json['id'] ?? 0,
      number: json['number'] ?? 0,
      title: json['title'] ?? '',
      state: json['state'] ?? '',
      url: json['url'] ?? '',
      htmlUrl: json['html_url'] ?? '',
      body: json['body'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      closedAt: json['closed_at'],
      mergedAt: json['merged_at'],
      user: json['user'] != null ? GitUser.fromJson(json['user']) : const GitUser(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'title': title,
      'state': state,
      'url': url,
      'html_url': htmlUrl,
      'body': body,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'closed_at': closedAt,
      'merged_at': mergedAt,
      'user': user.toJson(),
    };
  }

  PullRequest copyWith({
    int? id,
    int? number,
    String? title,
    String? state,
    String? url,
    String? htmlUrl,
    String? body,
    String? createdAt,
    String? updatedAt,
    String? closedAt,
    String? mergedAt,
    GitUser? user,
  }) {
    return PullRequest(
      id: id ?? this.id,
      number: number ?? this.number,
      title: title ?? this.title,
      state: state ?? this.state,
      url: url ?? this.url,
      htmlUrl: htmlUrl ?? this.htmlUrl,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      closedAt: closedAt ?? this.closedAt,
      mergedAt: mergedAt ?? this.mergedAt,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
    id,
    number,
    title,
    state,
    url,
    htmlUrl,
    body,
    createdAt,
    updatedAt,
    closedAt,
    mergedAt,
    user,
  ];
}

class GitUser extends Equatable {
  final int id;
  final String login;
  final String avatarUrl;
  final String htmlUrl;

  const GitUser({
    this.id = 0,
    this.login = '',
    this.avatarUrl = '',
    this.htmlUrl = '',
  });

  factory GitUser.fromJson(Map<String, dynamic> json) {
    return GitUser(
      id: json['id'] ?? 0,
      login: json['login'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      htmlUrl: json['html_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': login,
      'avatar_url': avatarUrl,
      'html_url': htmlUrl,
    };
  }

  GitUser copyWith({
    int? id,
    String? login,
    String? avatarUrl,
    String? htmlUrl,
  }) {
    return GitUser(
      id: id ?? this.id,
      login: login ?? this.login,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      htmlUrl: htmlUrl ?? this.htmlUrl,
    );
  }

  @override
  List<Object?> get props => [id, login, avatarUrl, htmlUrl];
}
