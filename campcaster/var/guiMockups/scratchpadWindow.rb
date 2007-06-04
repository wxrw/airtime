#!/usr/bin/env ruby

#-------------------------------------------------------------------------------
#   Copyright (c) 2004 Media Development Loan Fund
#
#   This file is part of the Campcaster project.
#   http://campcaster.campware.org/
#   To report bugs, send an e-mail to bugs@campware.org
#
#   Campcaster is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   Campcaster is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with Campcaster; if not, write to the Free Software
#   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
#   Author   : $Author$
#   Version  : $Revision$
#   Location : $URL$
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#   Mockup of the Scratchpad window.
#
#   glade file: scratchpadWindow.glade
#-------------------------------------------------------------------------------

require 'libglade2'

class ScratchpadWindow
    public
        def initialize(path)
            @glade = GladeXML.new(path) {
                |handler| method(handler)
            }
            
            @listStore = Gtk::ListStore.new(String)
            addrow("Song One")
            addrow("Song Two")
            addrow("Song Three")
            
            treeView = @glade["treeview1"]
            treeView.model = @listStore
            
            audioClipIcon = Gdk::Pixbuf.new("audioClipIcon.png")
            cellRenderer0 = Gtk::CellRendererPixbuf.new
            cellRenderer0.pixbuf = audioClipIcon
            treeViewColumn0 = Gtk::TreeViewColumn.new("Type",
                                                      cellRenderer0)
            treeView.append_column(treeViewColumn0)
            
            cellRenderer1 = Gtk::CellRendererText.new
            treeViewColumn1 = Gtk::TreeViewColumn.new("Title",
                                                      cellRenderer1,
                                                      :text => 0)
            treeView.append_column(treeViewColumn1)
        end

        def addrow(contents)
            iter = @listStore.append
            iter[0] = contents
        end

        def run
            mainWindow = @glade["window1"]
            mainWindow.signal_connect("hide") do
                Gtk.main_quit
            end
            mainWindow.show_all
            Gtk.main
        end
end

Gtk.init
path = File.dirname(__FILE__)
scratchpadWindow = ScratchpadWindow.new(path + "/scratchpadWindow.glade")
scratchpadWindow.run

