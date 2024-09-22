import util from "util";
import {parseStringPromise} from "xml2js";
import fs from "fs";

// Convert callback-based functions to promises
const readFile = util.promisify(fs.readFile);

// Async function to read and parse the iTunes library XML file
async function readITunesLibrary(filePath, playlistId) {
    try {
        const data = await readFile(filePath);
        const result = await parseStringPromise(data.toString(), {});

        const tracks = {};

            const plist = result.plist.dict[0];

            // Collect all tracks with their details
            plist.dict[0].dict.forEach(track => {
                const trackId = track.integer[0];
                tracks[trackId] = {
                    trackId,
                    title: track.string[2],
                    artist: track.string[3],
                    album: track.string[10],
                };
            });

        const playlistInfo = plist.array[0].dict.find(pl => pl.string && pl.string.includes(playlistId));

        if (playlistInfo) {
            console.log(playlistInfo.array);
            const playlistTracks = playlistInfo.array[0].dict.map(item => item.integer[0]);

            playlistTracks.forEach(trackId => {
                const track = tracks[trackId];
                if (track) {
                    console.log(`${track.title} - ${track.artist} - ${track.album}`);
                }
            });
        } else {
            console.log("Playlist not found.");
        }
    } catch (err) {
        console.error("An error occurred:", err);
    }
}

// Usage
const filePath = 'apple/iTunes Music Library.xml';
const playlistId = '01261CE29C600040'; // Example playlist ID
readITunesLibrary(filePath, playlistId);
