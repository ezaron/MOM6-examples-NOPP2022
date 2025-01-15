#
# Run this script from within an INPUT directory to build symlinks to files if they
# aleady exist on this system.
#
using Printf

datasetroot = "/glade/u/home/ezaron/MOM6-examples-flat/datasets.cheyenne"
#datasetroot = "../../../datasets.cheyenne"

mypid = @sprintf("%i",getpid())
run(pipeline(`ls -la`,"original_listing." * mypid))

fl = split(readchomp(`ls -1`))
fl = split(readchomp(`find . -maxdepth 1 -type l`))

orphans = []

f1 = fl[3]
for f1=fl
    println("Working on file = ",f1)
    f1t = string(f1[3:end]) # trim leading "./"
    
    if (isfile(f1t))
        println(" ... already exists")
        continue
    else
        if (f1t == ".datasets")
            println("Found a link to .datasets -- skipping")
        else
            f1r = split(readchomp(`find -L $datasetroot -name $f1t`))
            if (length(f1r) == 0)
                println(" ... Cannot find a matching filename for ",f1)
                println("     You must locate the file manually!")
                push!(orphans,f1)
                continue
            end
            f1r = f1r[1]
            println(" ... deleting the dead symlink")
            run(`rm $f1t`)
            println(" ... creating a fresh symlink")
            run(`ln -s $f1r $f1t`)
        end
    end
end
println("*******************************************************")
println("Here is the list of orphans you need to setup manually:")
show(orphans)
