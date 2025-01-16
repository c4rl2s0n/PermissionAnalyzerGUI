const String pkAppDirectory = 'pkAppDirectory';
const String pkDbFile = 'pkDbFile';

const String defaultRecorderDestinationPath = "/data/local/tmp/mysendevent";
const String defaultInputRecordDestinationPath = "/data/local/tmp/record.txt";

const String kTlTotal = "Total";

// traffic group tags
const String tEndpoint = "Endpoint";
const String tIpOnly = "Only IP";
const String tHostname = "Has Hostname";
const String tNoHostname = "No Hostname";
const String tSniEndpoint = "SNI Endpoint";
const String tServerName = "Has Server Name";
const String tNoServerName = "No Server Name";
const String tGroup = "Group";
const String tApplication = "Application";
const String tScenario = "Scenario";
const String tConstellation = "Constellation";
const String tTest = "Test";
const String tCommon = "Common";
const String tNotCommon = "Not Common";
const String tUnique = "Unique";
const String tNotUnique = "Not Unique";
const String tHighlight = "Highlight";
const String tNoHighlight = "No Highlight";

const List<String> graphTags = [
  // Group
  tGroup,
  tApplication,
  tScenario,
  tConstellation,
  tTest,
  // Endpoint
  tEndpoint,
  tIpOnly,
  tHostname,
  tNoHostname,
  tServerName,
  tNoServerName,
  tSniEndpoint,
  tCommon,
  tNotCommon,
  tUnique,
  tNotUnique,
  tHighlight,
  tNoHighlight,
];
