class CommandsTimeTracker < Formula
  desc "A universal command time tracker"
  homepage "https://github.com/ThiagoEvoa/commands_time_tracker"
  url "https://github.com/ThiagoEvoa/commands_time_tracker/archive/v1.2.3.tar.gz"
  sha256 "901eb6487cf1de2a3cc203ba95e13581c25a623a013193ad4ff8d3a07c767602"

  license "MIT"

  def install
    bin.install "bin/summarize.zsh" => "summarize"
    pkgshare.install "bin/time_tracker.sh"
  end

  def caveats
    <<~EOS
      To start tracking your commands, add the following line to your .zshrc:
      
        source #{opt_pkgshare}/time_tracker.sh
      
      To enable automatic 12-hour summaries, run this command:
      
        (crontab -l 2>/dev/null; echo "0 */12 * * * #{opt_bin}/summarize >> ~/summarizer.log 2>&1") | crontab -
      
      - To remove the automated cron job: summarize --uninstall
    EOS
  end

  test do
    assert_predicate bin/"summarize", :exist?
  end
end
