import '../../../../../common_libraries.dart';

class OpenPullRequestTabView extends StatefulWidget {
  const OpenPullRequestTabView({super.key});

  @override
  State<OpenPullRequestTabView> createState() => _OpenPullRequestTabViewState();
}

class _OpenPullRequestTabViewState extends State<OpenPullRequestTabView> {
  @override
  void initState() {
    context.read<PullRequestViewModelBloc>().add(FetchOpenPullRequests());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PullRequestViewModelBloc, PullRequestViewModelState>(
      builder: (context, state) {
        return PullRequestList(
          pullRequests: state.openPullRequests,
          status: "Open", // or "Closed"
        );
      },
    )
    ;
  }
}
