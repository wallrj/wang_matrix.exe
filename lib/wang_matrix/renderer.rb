module WangMatrix
  class Renderer
    def initialize
      Ncurses.initscr
      Ncurses.start_color
      Ncurses.cbreak
      Ncurses.curs_set(0)

      Ncurses.init_pair(1, Ncurses::COLOR_WHITE, Ncurses::COLOR_BLACK)
      Ncurses.init_pair(2, Ncurses::COLOR_RED, Ncurses::COLOR_BLACK)
    end

    def perform(grid:, path:)
      screen.clear

      screen.attrset(Ncurses::COLOR_PAIR(1))
      screen.mvaddstr(0,0, grid.map(&:join).join("\n") + "\n\n")

      screen.attrset(Ncurses::COLOR_PAIR(2))
      path.each do |pos|
        screen.mvaddstr(pos.y, pos.x, "X")
      end

      screen.refresh
    end

    def present_solution(grid:, path:)
      perform(grid: grid, path: path)

      screen.attrset(Ncurses::COLOR_PAIR(1))
      screen.mvaddstr(grid.size + 1, 0, "Press any key to exit")
      screen.refresh

      Ncurses.getch
      reset_screen
    end

    def reset_screen
      # put the screen back in its normal state
      Ncurses.echo()
      Ncurses.nocbreak()
      Ncurses.nl()
      Ncurses.endwin()
      Ncurses.curs_set(1)
    end

    private

      def screen
        Ncurses.stdscr
      end
  end
end
