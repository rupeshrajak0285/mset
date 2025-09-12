import '../../../../../common_libraries.dart';

class OpenPullRequestTabView extends StatefulWidget {
  const OpenPullRequestTabView({super.key});

  @override
  State<OpenPullRequestTabView> createState() => _OpenPullRequestTabViewState();
}

class _OpenPullRequestTabViewState extends State<OpenPullRequestTabView> {
  @override
  void initState() {
    super.initState();
    context.read<PullRequestViewModelBloc>().add(FetchOpenPullRequests());
  }

  Future<void> _onRefresh() async {
    /// 🔹 Trigger API call again
    context.read<PullRequestViewModelBloc>().add(FetchOpenPullRequests());
    /// Add a small delay so RefreshIndicator doesn’t disappear too fast
    await Future.delayed(const Duration(milliseconds: 800));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PullRequestViewModelBloc, PullRequestViewModelState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: PullRequestList(
            pullRequests: state.openPullRequests,
            status: "Open",
            pageStatus: state.pageStatus,
          ),
        );
      },
    );
  }
}
