import '../../../../../common_libraries.dart';

class ClosePullRequestTabView extends StatefulWidget {
  const ClosePullRequestTabView({super.key});

  @override
  State<ClosePullRequestTabView> createState() => _ClosePullRequestTabViewState();
}

class _ClosePullRequestTabViewState extends State<ClosePullRequestTabView> {
  @override
  void initState() {
    context.read<PullRequestViewModelBloc>().add(FetchClosedPullRequests());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PullRequestViewModelBloc, PullRequestViewModelState>(
      builder: (context, state) {
        return PullRequestList(
          pullRequests: state.closePullRequests,
          status: "Closed", // or "Closed"
        );
      },
    )
    ;
  }
}
