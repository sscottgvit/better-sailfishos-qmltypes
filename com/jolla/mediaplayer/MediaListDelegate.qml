/*
 * Copyright (C) 2012-2015 Jolla Ltd.
 *
 * The code in this file is distributed under multiple licenses, and as such,
 * may be used under any one of the following licenses:
 *
 *   - GNU General Public License as published by the Free Software Foundation;
 *     either version 2 of the License (see LICENSE.GPLv2 in the root directory
 *     for full terms), or (at your option) any later version.
 *   - GNU Lesser General Public License as published by the Free Software
 *     Foundation; either version 2.1 of the License (see LICENSE.LGPLv21 in the
 *     root directory for full terms), or (at your option) any later version.
 *   - Alternatively, if you have a commercial license agreement with Jolla Ltd,
 *     you may use the code under the terms of that license instead.
 *
 * You can visit <https://sailfishos.org/legal/> for more information
 */

// -*- qml -*-

import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.Media 1.0
import com.jolla.mediaplayer 1.0

MediaListItem {
    id: mediaListDelegate
    property var formatFilter

    highlighted: down || menuOpen
    playing: media.url == visualAudioAppModel.metadata.url
    duration: media.duration
    title: Theme.highlightText(media.title, RegExpHelpers.regExpFromSearchString(formatFilter, false), Theme.highlightColor)
    textFormat: Text.StyledText
    subtitleTextFormat: Text.AutoText
    subtitle: media.author
    onPlayingChanged: if (playing) ListView.view.currentIndex = model.index
}
