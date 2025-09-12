import '../../../../../common_libraries.dart';

class ClosePullRequestTabView extends StatefulWidget {
  const ClosePullRequestTabView({super.key});

  @override
  State<ClosePullRequestTabView> createState() => _ClosePullRequestTabViewState();
}

class _ClosePullRequestTabViewState extends State<ClosePullRequestTabView> {
  @override
  void initState() {
    super.initState();
    context.read<PullRequestViewModelBloc>().add(FetchClosedPullRequests());
  }

  Future<void> _onRefresh() async {
    /// 🔹 Trigger API call again
    context.read<PullRequestViewModelBloc>().add(FetchClosedPullRequests());
    /// Small delay for smooth animation
    await Future.delayed(const Duration(milliseconds: 800));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PullRequestViewModelBloc, PullRequestViewModelState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: PullRequestList(
            pullRequests: state.closePullRequests,
            status: "Closed",
            pageStatus: state.pageStatus,
          ),
        );
      },
    );
  }
}
