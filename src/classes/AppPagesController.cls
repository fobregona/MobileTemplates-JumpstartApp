public class AppPagesController {

	@RemoteAction
	public static List<AppPageSpringboard> getAppPages(String appId) {
		List<AppPageSpringboard> aps = new List<AppPageSpringboard>();
		String queryString = 'SELECT id, Title__c, Description__c, Background_Color__c, (SELECT id FROM attachments) FROM Apppage__c WHERE DemoApp__c = \''+appId+'\' ORDER BY name ASC';
		List<Apppage__c> appPages = Database.query(queryString);

		for (AppPage__c ap: appPages) {
			aps.add(new AppPageSpringboard(ap));
		}

		return aps;
	}

	public class AppPageSpringboard {
		Apppage__c appPage;
		List<Springboard_Pages__c> springboards;

		public AppPageSpringboard(Apppage__c ap) {
			appPage = ap;
			springboards = [SELECT Springboard__r.Action_Name__c, Springboard__r.Visualforce_Page_Name__c, Springboard__r.Full_URL__c, Springboard__r.Requires_Login__c FROM Springboard_Pages__c WHERE App_Page__c =: appPage.id];
		}
	}
}