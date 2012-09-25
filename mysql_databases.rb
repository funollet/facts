# fact: mysql_databases
#
# Returns list of Mysql databases in CSV format.


have_mysqld = %x{which mysqld_safe > /dev/null 2>&1}

if $?.exitstatus == 0
    Facter.add(:mysql_databases) do
        setcode do
            cmd = "mysql -qsN  --connect_timeout=1 -e 'show databases'"
            Facter::Util::Resolution.exec(cmd).gsub(/\n/, ',')
        end
    end
end
