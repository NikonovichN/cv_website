enum RouterPath {
  welcome("/welcome"),
  skills("/skills"),
  experience("/experience"),
  error("/error"),
  ;

  const RouterPath(this.path);

  final String path;
}
