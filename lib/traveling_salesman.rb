#Itinerary for a Traveling Salesman
#       A salesman wants to call on his customers, each of which is located 
#       in a different city. He asks you to prepare an itinerary for him that 
#       will minimize his driving miles. The itinerary must take him to each 
#       city exactly once and return him to his starting point. Can you write 
#       a Ruby program to generate such an itinerary?
#
#       This problem is famous and known to be NP-complete. 
#
#       First take a grid of points as defined by the programme.
#
#       Second, let's relax the requirement that the itinerary be truly minimal. 
#       Let's only require that it be nearly minimal, say, within 5%. Now you can 
#       tackle the problem with one of several heuristic optimization algorithms 
#       which run in polynomial time. In particular, you could use a genetic algorithm (GA).
#
#       From one point of view a GA is a stochastic technique for solving an 
#       optimization problem--for finding the extremum of a function. From another 
#       point of view it is applied Darwinian evolution.
#
#       To see how a GA works, let's look at some pseudocode.
#           Step 1.  Generate a random initial population of itineraries.
#           Step 2.  Replicate each itinerary with some variation.
#           Step 3.  Rank the population according to a fitness function.
#           Step 4.  Reduce the population to a prescribed size,
#                    keeping only the best ranking itineraries.
#           Step 5.  Go to step 2 unless best itinerary meets an exit criterion.
#       
#       A great aspect of genetic algorithms is that you really don't need to know 
#       much about the problem domain in order to find a workable solution for it. 
#       That comes with tradeoffs though, naturally. It takes longer to find a 
#       solution this way and there are no guarantees it will be great when you do 
#       settle on something. Still, I think it's very valuable to examine just how 
#       these solutions work.
#
class Grid
  # Square grid (order n**2, where n is an integer > 1). Grid points are
  # spaced on the unit lattice with (0, 0) at the lower left corner and
  # (n-1, n-1) at the upper right.
  attr_reader :n, :pts, :min
  def initialize(n)
    raise ArgumentError unless Integer === n && n > 1
    @n = n
    @pts = []
    n.times do |i|
      x = i.to_f
      n.times { |j| @pts << [x, j.to_f] }
    end
    # @min is length of any shortest tour traversing the grid.
    @min = n * n
    @min += Math::sqrt(2.0) - 1 if @n & 1 == 1
  end
end

include Magick
class GeneticGridGuess
  def initialize grid
    @grid, @min = grid.pts, grid.min*1.05
    puts "Minumum time (within 5%): #{@min}"
    @len, @seg = @grid.length, (@grid.length*0.3).ceil
    @psize = Math.sqrt(@len).ceil*60
    @mby = (@psize/20).ceil
    @pop = []
    @psize.times do
      i = @grid.sort_by { rand }
      @pop << [dist(i),i]
    end
    popsort
  end

  def dist i
    # Uninteresting but fast as I can make it:
    t = 0
    g = i+[i[0]]
    @len.times do |e|
      t += Math.sqrt((g[e][0]-g[e+1][0])**2+(g[e][1]-g[e+1][1])**2)
    end
    t
  end

  def popsort
    @pop = @pop.sort_by { |e| e[0] }
  end
  
  def solve
    while iter[0] > @min
      puts @pop[0][0]
    end
    @pop[0]
  end

  def iter
    @pop = (@pop[0..20]*@mby).collect do |e|
      n = e[1].dup
      case rand(10)
        when 0..6 #Guesses concerning these values
          seg = rand(@seg)
          r = rand(@grid.length-seg+1)
          n[r,seg] = n[r,seg].reverse
        when 7
          n = n.slice!(rand(@grid.length)..-1) + n
        when 8..9
          r = []
          3.times { r << rand(@grid.length)}
          r.sort!
          n = n[0...r[0]] + n[r[1]...r[2]] + n[r[0]...r[1]] + n[r[2]..-1]
      end

      [dist(n),n]
    end

    popsort
    @pop[0]
  end
end

gridsize = ARGV[0] ? ARGV[0].to_i : (print "Grid size: "; STDIN.gets.to_i)
grid = GeneticGridGuess.new(Grid.new(gridsize)).solve

puts "In time #{grid[0]}:"
grid[1].each do |e|
  print "#{e[0].to_i},#{e[1].to_i} "
end
puts


if !ARGV[1]
  
  image = RVG.new(gridsize*100,gridsize*100) do |canvas|
    canvas.background_fill = 'white'
    cgrid = grid[1].collect do |e|
      [e[0]*100+10,e[1]*100+10]
    end
    cgrid.each do |point|
      canvas.circle(5,point[0],point[1]).styles(:fill=>'black')
    end
    canvas.polygon(*cgrid.flatten).styles(:stroke=>'black', :stroke_width=>2, :fill=>'none')

  end.draw

  image.display rescue image.write("#{gridsize}x#{gridsize}tour.jpg")
end
