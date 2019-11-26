lib = require 'lgi'

sqlite3 = require 'lsqlite3'
db = sqlite3.open('ad_sar')

pixbuf = lib.GdkPixbuf.Pixbuf
gtk = lib.Gtk

gtk.init()
bld = gtk.Builder()
bld:add_from_file('Lesson.glade')
ui = bld.objects


c1 = gtk.TreeViewColumn {title = 'Name' ,{gtk.CellRendererText {},{text = 1}} }
c2 = gtk.TreeViewColumn {title = 'Value' ,{gtk.CellRendererText {},{text = 2}} }
c3 = gtk.TreeViewColumn {title = 'IMG' ,{gtk.CellRendererPixbuf {},{pixbuf = 3}} }

ui.less:append_column(c1)
ui.less:append_column(c2)
ui.less:append_column(c3)


for name,col,img in db:urows('SELECT * FROM adeptus_saroritas') do
col = tonumber(col)

picture = pixbuf.new_from_file(img)

podorognik = ui.ID_less:append()
ui.ID_less[podorognik] = {[1] = name, [2] = col, [3] = picture}
end



ui.lesson.on_destroy = gtk.main_quit

ui.lesson:show_all()
gtk.main()

