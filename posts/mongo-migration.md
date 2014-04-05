{{{
  "title":"Simple Mongo Migration",
  "tags" :["mongo", "db", "migration"],
  "date" : "09/05/2013",
  "category": "mongo"
}}}

#### Javascript instead of SQL

The shell for mongo uses javascript to manipulate data. So, when I needed to
migrate the documents from my dev database into the production (which is
strange to do, I know.) it was just a matter of writing up a simple forEach loop.


    > use dev
    > var docs = db.notes.find()
    >
    > use production
    > docs.forEach(function(doc) { db.notes.insert(doc) })


<!--more-->

Of course you could do whatever fancy stuff you wanted there to grab only the
docs you wanted. If you only want to migrate your cheese notes:

    > var docs = db.notes.find({ $or: [{title: "cheese"}, {content: "cheese"}] })

This to me is much more intuitive than the equivalent SQL, but hopefully that's
a helpful reminder. Your mongo database is manipulated via javascript. Do it
up!

