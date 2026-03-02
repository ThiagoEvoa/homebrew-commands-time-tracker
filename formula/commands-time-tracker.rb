class CommandsTimeTracker < Formula
  desc "A universal command time tracker"
  homepage "https://github.com/ThiagoEvoa/commands_time_tracker"
  url "https://github.com/ThiagoEvoa/commands_time_tracker/archive/v1.1.2.tar.gz"

  license "MIT"

  def install
    bin.install "bin/summarize.zsh" => "summarize"
    pkgshare.install "bin/time_tracker.sh"
  end

  def post_install
    script_path = "#{opt_bin}/summarize"
    cron_job = "0 */12 * * *#{script_path} >> #{Dir.home}/summarizer.log 2>&1"
    unless `crontab -l 2>/dev/null`.include?(script_path)
      system "crontab -l 2>/dev/null | { cat; echo '#{cron_job}'; } | crontab -"
    end
  end

  def caveats
    <<~EOS
      To start tracking your commands, add the following line to your .zshrc:
      
        source #{opt_pkgshare}/time_tracker.sh
      
      A cron job has been automatically added to run the summary every 12h.
      Logs can be found in ~/summarizer.log if needed.

      To remove the automated cron job, run:
        crontab -l | grep -v "summarize" | crontab -
        or
        summarize --uninstall
    EOS
  end

  test do
    assert_predicate bin/"summarize", :exist?
  end
end
