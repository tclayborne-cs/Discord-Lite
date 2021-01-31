using Gtk;
using WebKit;

public class ValaBrowser : Window {

    private const string TITLE = "Discord Lite";
    private const string DEFAULT_URL = "https://discordapp.com/";
    private const string DEFAULT_PROTOCOL = "https";
    private Regex protocol_regex;
    private WebView web_view;

    public ValaBrowser () {
        this.title = ValaBrowser.TITLE;
        set_default_size (1200, 720);

        try {
            this.protocol_regex = new Regex (".*://.*");
        } catch (RegexError e) {
            critical ("%s", e.message);
        }

        create_widgets ();
        connect_signals ();
    }

    private void create_widgets () {
        var toolbar = new Toolbar ();
        this.web_view = new WebView ();
        var scrolled_window = new ScrolledWindow (null, null);
        scrolled_window.set_policy (PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
        scrolled_window.add (this.web_view);
        var box = new Box (Gtk.Orientation.VERTICAL, 0);
        box.pack_start (toolbar, false, true, 0);
        box.pack_start (scrolled_window, true, true, 0);
        add (box);
    }

    private void connect_signals () {
        this.destroy.connect (Gtk.main_quit);
    }

    public void start () {
        show_all ();
        this.web_view.load_uri (DEFAULT_URL);
    }

    public static int main (string[] args) {
        Gtk.init (ref args);

        var browser = new ValaBrowser ();
        browser.start ();

        Gtk.main ();

        return 0;
    }
}
