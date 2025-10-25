# Pending review
{pkgs, ...}: {
  home.packages = with pkgs; [
    ffmpeg # media converter
    pandoc # markup converter
    yt-dlp # download youtube videos
    rclone # easily mount remote storage
  ];

  home.shellAliases = {
    ytv = "yt-dlp --format 'bestvideo+bestaudio[ext=m4a]/bestvideo+bestaudio/best' --merge-output-format mp4";
    yta-best = "yt-dlp --extract-audio --audio-format best";
    yta-aac = "yt-dlp --extract-audio --audio-format aac";
    yta-flac = "yt-dlp --extract-audio --audio-format flac";
    yta-m4a = "yt-dlp --extract-audio --audio-format m4a";
    yta-mp3 = "yt-dlp --extract-audio --audio-format mp3";
    yta-opus = "yt-dlp --extract-audio --audio-format opus";
    yta-vorbis = "yt-dlp --extract-audio --audio-format vorbis";
    yta-wav = "yt-dlp --extract-audio --audio-format wav";
  };
}
