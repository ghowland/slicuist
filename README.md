# SLoCUST

## Sub-Linear Complexity UI System Template

SLoCUST, or Slocust, is an example of my methodology for doing dynamic client-server in a way that takes minimal setup, and can scale massively, while costing sub-linear amounts of effort to set up new UI.

I have often read complaints about how the Web is a ghetto compared to traditional rich GUI libraries, which I have found to be exactly the opposite for myself.  I have worked with traditional GUI libraries for over 20 years and have found them very difficult to get initially set up, and even more difficult to change once they are set up, and very limited in terms of how much depth and breadth can be added to them.  

Frequently early decisions limit the amount of UI that can actually be created later, as the data structures are simply not available or cannot be connected with a reasonable amount of work to existing UI.

In contrast, the methodology I have been using through browsers (HTML/JS on the Client, with the majority of dynamic generation on the server) has been scaling excellently for me for the past 10 years (now 2015), and I would say is "infinitely" scalable with a "sub-linear" amount of effort and complexity, which means that as you add more UI to an application it takes less time than it did the first time for additional components of a similar nature.

The goal of efficiency should be to create logarithmic functions, but this takes many efficiencies to create, and may ultimately be impossible and require an "M*log(N)" algorithm at best.  Still, sub-linear is a great efficiency over the N^2 and above type complexities I have found in working with traditional GUI libraries and frameworks.

## Installation

You will need Python 2 and the library Flask.  Install this with Pip:

```
pip install flask
```

Then pull down this repo locally:

```
git clone https://github.com/ghowland/slocust.git
```

Then run the server from the repo directory:

```
./start.sh
```

And direct your browser to this page:

```
http://127.0.0.1:5000/
```

## Example Website

I am using the base Bootstrap web template released under the Apache 2.0 license at: http://startbootstrap.com/template-overviews/sb-admin-2/

You can find the full files under the <a href="web_template/">web_template/</a> path for your convenience, but you can also pull this down from the above link or through Bower also described in the above link.  Obviously the Slocust technique works with any type of HTML-style client-server request workflow, so this is just a convenient example as it has many UI elements put together already for us.

The active web files that the Python dynamic web server is using are under the <a href="templates/">templates/</a> path, which are stripped down versions of the <a href="web_template/">web_template/</a> content.  For my development methods I like to keep example files close by so I can copy and paste things out of them to test new UI, so I am leaving these slightly duplicated in this format so I can continue to extend this demonstration in my usual method, and you can use this method as well.

The <a href="templates/">templates/</a> path will also server as our Document Root for the static files of the server, although the program will be launched from the project-root directory ("./"), so both the <a href="code/">code/</a> and <a href="templates/">templates/</a> directory are reachable as children.  The <a href="database/">database/</a> will contain an example SQLite 3 database called "opsdb.db", which I will use to populate dynamic data in the Python Flask server.  There are backups of this database and an HTML representation of the data in <a href="database/sql_backups/">database/sql_backups/</a> which will show the progression of this schema and data through SQL dumps, for those interested in that.

I have written the example Python dynamic web server portion of this using Flask, which is a "micro-framework", and thus has very short coe paths.  The initial version is a very simple and naive RPC implementation.  I may extend this to demonstrate REST and other styles of RPC in the future, but those are not necessary to demonstrate this technique as they are just syntax sugar and conventions for a different type of scalability (mostly, name spaces and consistent access methods).
